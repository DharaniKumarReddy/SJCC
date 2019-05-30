//
//  DashboardViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 06/04/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import WebKit
import Toast_Swift
import Firebase

class DashboardViewController: UIViewController {
    
    // MARK:- Variables
    private var gallery: [HomeGallery] = []
    private var news: [News] = []
    private var notifications: [Notification] = []
    
    var slidePosition = 0
    
    var slideImages: [UIImage] = []
    var webView: WKWebView!
    private var isNotifiedAlertDismissed = true
    private var isShowingNews = false
    private var isShowingNotifications = false
    
    var registeredNumberField: UITextField?
    var phoneNumberField: UITextField?
    
    private var activityController : UIActivityViewController!
    
    // MARK:- IBOutlets
    @IBOutlet private var tabImages: [UIImageView]!
    @IBOutlet private weak var webHolderView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var slidingImageTitle: UILabel!
    @IBOutlet private weak var homeGalleryButton: UIButton!
    @IBOutlet private weak var slidingImageView: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var newsLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var notificationsIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var webpageIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tabBarViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var indicatorViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var blueGradientViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarViewHeightConstraint.constant = bottomSafeArea+60
        blueGradientViewHeightConstraint.constant = topSareArea+44
        navigationController?.navigationBar.barStyle = .black
        slideMenuController()?.changeLeftViewWidth(screenWidth-screenWidth/5)
        SlideMenuOptions.contentViewScale = 1.0
        // Set the PinterestLayout delegate
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewCustomLayout {
            layout.delegate = self
        }
        navigationController?.transparentBar()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        AppDelegate.getAppdelegate()?.dashboard = self
        loadWebView()
        getHomeGallery()
        getNews()
        getNotifications()
    }
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: getViewHeight())
        webHolderView.insertSubview(webView, at: 0) //addSubview(webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: Constant.UserDefaults.isStaffLoggedIn) {
            Messaging.messaging().subscribe(toTopic: "faculty")
        }
    }
    
    // MARK:- Private Methods
    private func animateIndicator(index: CGFloat) {
        UIView.animate(withDuration: 0.3, animations: {
            self.indicatorViewLeadingConstraint.constant = index * (screenWidth/4)
            self.view.layoutIfNeeded()
        })
    }
    
    private func animateScrollView(point: CGPoint) {
        scrollView.setContentOffset(point, animated: true)
    }
    
    private func getHomeGallery() {
        APICaller.getInstance().getHomeGallery(onSuccess: { gallery in
            self.gallery = gallery
            self.downloadImages(gallery)
        }, onError: {_ in
            
        })
    }
    
    private func downloadImages(_ gallery: [HomeGallery]) {
        var slidePhotos: [UIImage] = []
        for photo in gallery {
            photo.image.downloadImage(completion: { image in
                slidePhotos.append(image)
                if gallery.count == slidePhotos.count {
                    DispatchQueue.main.async {
                        self.animateImageSlides(images: slidePhotos)
                    }
                }
            })
        }
    }

    private func animateImageSlides(images: [UIImage]) {
        slideImages = images
        homeGalleryButton.isUserInteractionEnabled = true
        loadSliding()
    }
    
    private func loadSliding() {
        if self.slidePosition >= self.gallery.count {
            slidePosition = 0
        }
        slidingImageTitle.text = self.gallery[slidePosition].title
        slidingImageView.image = slideImages[slidePosition]
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.slidePosition += 1
            self.loadSliding()
        }
    }
    
    private func getNews() {
        APICaller.getInstance().getNews(onSuccess: { news in
            self.news = news
            self.newsLoadingIndicator.stopAnimating()
            self.collectionView.reloadData()
        }, onError: {_ in})
    }
    
    internal func getNotifications() {
        APICaller.getInstance().getNotifications(onSuccess: { notifications in
            let defaults = UserDefaults.standard
            if defaults.bool(forKey: Constant.UserDefaults.isStaffLoggedIn) == true {
                self.notifications = notifications
            } else {
                self.notifications = notifications.filter({ $0.topicName == "student" })
            }
//            self.notifications = notifications
            self.notificationsIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func loadWebView() {
        
        let myURL = URL(string:"http://sjcc.edu.in/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    private func getViewHeight() -> CGFloat {
        let viewHeight = screenHeight - topSareArea - 44
        let tabsHeight = bottomSafeArea+60
        return (viewHeight - tabsHeight)
    }
    
    private func loadDefaultImages() {
        tabImages.filter({$0.tag == 0}).first?.image = UIImage(named: "Home")
        tabImages.filter({$0.tag == 1}).first?.image = UIImage(named: "News")
        tabImages.filter({$0.tag == 2}).first?.image = UIImage(named: "Notifications")
        tabImages.filter({$0.tag == 3}).first?.image = UIImage(named: "Web")
    }
    
    private func callNumber(number: String) {
        if let url = URL(string: "telprompt:\(number)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
    
    private func loadLoginView(userPlaceHolder: String, passwordPlaceHolder: String) {
        
        let window = UIApplication.shared.keyWindow!
        let popUpHolderView = UIView(frame: window.bounds)
        popUpHolderView.tag = 9999
        window.addSubview(popUpHolderView)
        
        let dismissButton = UIButton(frame: popUpHolderView.frame)
        dismissButton.addTarget(self, action: #selector(DashboardViewController.dismissPopUp), for: .touchUpInside)
        popUpHolderView.addSubview(dismissButton)
        popUpHolderView.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        
        let loginView = UIView(frame: CGRect(x: 50, y: 50, width: screenWidth-80, height: 200))
        loginView.center = window.center
        loginView.center.y = loginView.center.y - 50
        loginView.backgroundColor = UIColor.white
        loginView.layer.cornerRadius = 4.0
        popUpHolderView.addSubview(loginView)
        
        registeredNumberField = UITextField(frame: CGRect(x: 16, y: 22, width: screenWidth-112, height: 40))
        registeredNumberField?.placeholder = userPlaceHolder
        registeredNumberField?.textAlignment = .center
        registeredNumberField?.borderStyle = .line
        registeredNumberField?.becomeFirstResponder()
        registeredNumberField?.keyboardType = userPlaceHolder == "email" ? .emailAddress : .default
        
        phoneNumberField = UITextField(frame: CGRect(x: 16, y: 78, width: screenWidth-112, height: 40))
        phoneNumberField?.placeholder = passwordPlaceHolder
        phoneNumberField?.textAlignment = .center
        phoneNumberField?.borderStyle = .line
        phoneNumberField?.keyboardType = passwordPlaceHolder == "password" ?  .default : .numberPad
        phoneNumberField?.isSecureTextEntry = passwordPlaceHolder == "password"
        
        loginView.addSubview(registeredNumberField!)
        loginView.addSubview(phoneNumberField!)
        
        let loginButton = UIButton(frame: CGRect(x: screenWidth/2-100, y: 142, width: 100, height: 40))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "HoeflerText-Regular", size: 17)
        loginButton.backgroundColor = rgba(red: 235, green: 235, blue: 235)
        loginButton.layer.cornerRadius = 4.0
        loginButton.setTitleColor(UIColor.init(white: 0, alpha: 0.7), for: .normal)
        if userPlaceHolder == "email" {
            loginButton.addTarget(self, action: #selector(DashboardViewController.authenticateStaffLogin), for: .touchUpInside)
        } else {
            loginButton.addTarget(self, action: #selector(DashboardViewController.authenticateStudentLogin), for: .touchUpInside)
        }
        loginView.addSubview(loginButton)
    }
    
    @objc private func authenticateStudentLogin() {
        APICaller.getInstance().getStudentLoginDetails(registeredNumber: registeredNumberField?.text ?? "", phoneNumber: phoneNumberField?.text ?? "", onSuccess: { success in
            if success == 1 {
                self.dismissPopUp()
                UserDefaults.standard.set(true, forKey: Constant.UserDefaults.isStudentLoggedIn)
                let studentViewController = UIStoryboard.loadStudentViewController()
                self.navigationController?.pushViewController(studentViewController, animated: true)
            } else {
                self.view.makeToast("Invalid Credentials.", duration: 1.0, position: .top)
            }
        }, onError: {_ in})
    }
    
    @objc private func authenticateStaffLogin() {
        APICaller.getInstance().getStaffloginDetails(email: registeredNumberField?.text ?? "", password: phoneNumberField?.text ?? "", onSuccess: { success in
            if success == 1 {
                self.dismissPopUp()
                Messaging.messaging().subscribe(toTopic: "faculty")
                UserDefaults.standard.set(true, forKey: Constant.UserDefaults.isStaffDashboardLoggedIn)
                let staffViewController = UIStoryboard.loadStaffViewController()
                self.navigationController?.pushViewController(staffViewController, animated: true)
            } else {
                self.view.makeToast("Invalid Credentials", duration: 1.0, position: .top)
            }
        }, onError: {_ in})
    }
    
    @objc private func dismissPopUp() {
        getPopUpView()?.removeFromSuperview()
    }
    
    private func getPopUpView() -> UIView? {
        return UIApplication.shared.keyWindow?.subviews.filter({ $0.tag == 9999 }).first
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sjcc.edu.in/sjcc_app/newsshare.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
    
    // MARK:- IBActions
    @IBAction private func menuButton_Tapped() {
        slideMenuController()?.openLeft()
    }
    
    @IBAction private func tabBarButton_Tapped(button: UIButton) {
        let tag = CGFloat(button.tag)
        loadDefaultImages()
        tabImages.filter({$0.tag == Int(tag)}).first?.image = UIImage(named: ["home_selected", "news_selected", "notifications_selected", "web_selected"][Int(tag)])
        animateIndicator(index: tag)
        animateScrollView(point: CGPoint(x: tag * screenWidth, y: 0))
    }
    
    @IBAction private func swipeGestureRecognizer(gesture: UISwipeGestureRecognizer) {
        let currentXPoint = scrollView.contentOffset.x
        let xPoint = gesture.direction == .left ? currentXPoint+screenWidth : currentXPoint-screenWidth
        guard xPoint >= 0 && xPoint <= screenWidth*3 else { return }
        animateIndicator(index: xPoint/screenWidth)
        animateScrollView(point: CGPoint(x: xPoint, y: 0))
    }
    
    @IBAction private func webActionButtons_Tapped(button: UIButton) {
        let webUrl = ["http://sjcc.edu.in/sjcc_app/about_college.html", "http://sjcc.edu.in/sjcc_app/calendar.html", "http://sjcc.edu.in/sjcc_app/enquiry.php"][button.tag]
        pushWebViewController(webUrl)
    }
    
    @IBAction private func staffButton_Tapped() {
        guard !UserDefaults.standard.bool(forKey: Constant.UserDefaults.isStaffDashboardLoggedIn) else {
            let staffViewController = UIStoryboard.loadStaffViewController()
            self.navigationController?.pushViewController(staffViewController, animated: true)
            return
        }
        loadLoginView(userPlaceHolder: "email", passwordPlaceHolder: "password")
    }
    
    @IBAction private func parentsButton_Tapped() {
        let parentsViewController = UIStoryboard.loadParentsViewController()
        navigationController?.pushViewController(parentsViewController, animated: true)
    }
    
    @IBAction private func aluminiButton_Tapped() {
        let aluminiViewController = UIStoryboard.loadAluminiViewController()
        navigationController?.pushViewController(aluminiViewController, animated: true)
    }
    
    @IBAction private func newsLetterButton_Tapped() {
        let newsLetterViewController = UIStoryboard.loadNewsLetterViewController()
        navigationController?.pushViewController(newsLetterViewController, animated: true)
    }
    
    @IBAction private func admissionButton_Tapped() {
        let admissionsViewController = UIStoryboard.loadAdmissionsViewController()
        navigationController?.pushViewController(admissionsViewController, animated: true)
    }
    
    @IBAction private func homeGalleryButton_Tapped() {
        let homeGalleryViewController = UIStoryboard.loadHomeGalleryViewController()
        homeGalleryViewController.gallery = gallery
        navigationController?.pushViewController(homeGalleryViewController, animated: true)
    }
    
    @IBAction private func announcementsButton_Tapped() {
        let announcenmentsViewController = UIStoryboard.loadAnnouncementsViewController()
        navigationController?.pushViewController(announcenmentsViewController, animated: true)
    }
    
    @IBAction private func callButton_Tapped() {
        let callAlert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let firstNumberAction = UIAlertAction(title: "+91-8025360644", style: .default, handler: { _ in
            self.callNumber(number: "+91-8025360644")
        })
        let secondNumberAction = UIAlertAction(title: "+91-8025360646", style: .default, handler: { _ in
            self.callNumber(number: "+91-8025360646")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        callAlert.addAction(firstNumberAction)
        callAlert.addAction(secondNumberAction)
        callAlert.addAction(cancelAction)
        present(callAlert, animated: true, completion: nil)
    }
    
    @IBAction private func emailButton_Tapped() {
        let email = "info@sjcc.edu.in"
        if let url = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
    }
    
    @IBAction private func studentLoginButton_Tapped() {
        guard !UserDefaults.standard.bool(forKey: Constant.UserDefaults.isStudentLoggedIn) else {
            let studentViewController = UIStoryboard.loadStudentViewController()
            self.navigationController?.pushViewController(studentViewController, animated: true)
            return
        }
        loadLoginView(userPlaceHolder: "Enter Registered Number", passwordPlaceHolder: "Enter Phone Number")
    }
}

extension DashboardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NewsCollectionCellCell.self), for: indexPath) as? NewsCollectionCellCell
        cell?.loadData(news: news[indexPath.row])
        cell?.delegate = self
        cell?.tag = indexPath.row
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsDetailedViewController = UIStoryboard.loadNewsDetailViewController()
        newsDetailedViewController.news = news[indexPath.row]
        navigationController?.pushViewController(newsDetailedViewController, animated: true)
    }
}

extension DashboardViewController: ShareDelegate {
    func shareData(tag: Int) {
        loadActivityController(id: news[tag].id)
        present(activityController, animated: true, completion: nil)
    }
}

extension DashboardViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath) -> CGFloat {
        let titleHeight = news[indexPath.row].title.heightWithConstrainedWidth(width: (screenWidth/2)-6, font: UIFont(name: "Optima-Bold", size: 18)!)
        let descriptionHeight = news[indexPath.row].description.heightWithConstrainedWidth(width: (screenWidth/2)-6, font: UIFont(name: "Optima-Regular", size: 16)!)
        let cellHeight = 188 + max(22, titleHeight) + 8 + min(97, descriptionHeight) + 8
        return cellHeight
    }
}

class NewsCollectionCellCell: UICollectionViewCell {
    fileprivate weak var delegate: ShareDelegate?
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    
    fileprivate func loadData(news: News) {
        newsImageView.downloadImageFrom(link: news.image, contentMode: .scaleAspectFill)
        newsDateLabel.text = news.date
        newsTitleLabel.text = news.title
        newsDescriptionLabel.text = news.description
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.shareData(tag: tag)
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationTableCell.self)) as? NotificationTableCell
        cell?.loadData(notification: notifications[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

class NotificationTableCell: UITableViewCell {
    @IBOutlet private weak var notificationDateLabel: UILabel!
    @IBOutlet private weak var notificationTitleLabel: UILabel!
    @IBOutlet private weak var notificationDescriptionLabel: UILabel!
    
    fileprivate func loadData(notification: Notification) {
        notificationDateLabel.text = notification.date
        notificationTitleLabel.text = notification.title
        notificationDescriptionLabel.text = notification.description
    }
}

extension DashboardViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webpageIndicator.stopAnimating()
    }
}

// Helper function inserted by Swift 4.2 migrator.
internal func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

// MARK:- Push Notifications
extension DashboardViewController {
    /**
     Before notification going to invoke its controller, basic checks needs to be verified and notificaton will be fired.
     */
    internal func postRemoteNotification() {
        
        // Check Notification is recieved while app is foreground
        if isNotifiedAlertDismissed {
            self.isNotifiedAlertDismissed = false
            // Pop's up the alertview and notifiy user to whether he/she wants to reach notified controller
            guard TopViewController.isNotifiedController() && isNewsOrNotifications() else {
                showAlertViewController(PushNotificationHandler.sharedInstance.notificationTitle, message: truncateCharactersInNotificationMessage(PushNotificationHandler.sharedInstance.notificationMessage as NSString), cancelButton: "Close", destructiveButton: "", otherButtons: "Open", onDestroyAction: {
                    self.isNotifiedAlertDismissed = true
                    PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
                    self.presentNotifiedViewController()
                }, onCancelAction: {
                    self.isNotifiedAlertDismissed = true
                    // Making sure app is reached its destination view controller, so that future notifications will show
                    PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
                })
                return
            }
            isNotifiedAlertDismissed = true
            PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
        } else if isNotifiedAlertDismissed {
            
            //Looks for destined notification controller
            presentNotifiedViewController()
        } else {
            // Making sure app is reached its destination view controller, so that future notifications will show
            PushNotificationHandler.sharedInstance.isNotificationReachedItsDestination = true
        }
    }
    /**
     To confirm whether notification reached its destined controller.
     */
    private func isNotificationYetToReachItsDestination() {
        if PushNotificationHandler.sharedInstance.isPushNotificationRecieved {
            postRemoteNotification()
        }
    }
    
    private func isNewsOrNotifications() -> Bool {
        if PushNotificationHandler.sharedInstance.notificationType == 1 {
            return isShowingNews
        } else if PushNotificationHandler.sharedInstance.notificationType == 2 {
            return isShowingNotifications
        }
        return true
    }
    
    internal func presentNotifiedViewController() {
        //1 News
        //2 Announcement
        //3 NewsLetter
        //4 Notification
        
        print(PushNotificationHandler.sharedInstance.notificationType)
        PushNotificationHandler.sharedInstance.isPushNotificationRecieved = false
        let type = PushNotificationHandler.sharedInstance.notificationType
        switch type {
        case 1:
            loadTabBars(1)
        case 2:
            let announcenmentsViewController = UIStoryboard.loadAnnouncementsViewController()
            navigationController?.pushViewController(announcenmentsViewController, animated: true)
        case 3:
            let newsLetterViewController = UIStoryboard.loadNewsLetterViewController()
            navigationController?.pushViewController(newsLetterViewController, animated: true)
        case 4:
            loadTabBars(2)
        default:
            break
        }
    }
    
    private func loadTabBars(_ type: CGFloat) {
        loadDefaultImages()
        tabImages.filter({$0.tag == Int(type)}).first?.image = UIImage(named: ["home_selected", "news_selected", "notifications_selected", "web_selected"][Int(type)])
        animateIndicator(index: type)
        animateScrollView(point: CGPoint(x: type * screenWidth, y: 0))
    }
}
