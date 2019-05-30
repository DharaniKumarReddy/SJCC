//
//  MenuViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 07/04/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {

    var userNameField: UITextField?
    var passwordField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc private func dismissPopUp() {
        getPopUpView()?.removeFromSuperview()
    }
    
    @objc private func authenticateFirebase() {
        getPopUpView()?.isUserInteractionEnabled = false
        Auth.auth().signIn(withEmail: userNameField?.text ?? "", password: passwordField?.text ?? "") { user, error in
            self.getPopUpView()?.isUserInteractionEnabled = true
            self.dismissPopUp()
            if user != nil && error == nil {
                Messaging.messaging().subscribe(toTopic: "faculty")
                UserDefaults.standard.set(true, forKey: Constant.UserDefaults.isStaffLoggedIn)
                AppDelegate.getAppdelegate()?.dashboard?.getNotifications()
            }
        }
    }
    
    private func getPopUpView() -> UIView? {
        return UIApplication.shared.keyWindow?.subviews.filter({ $0.tag == 999 }).first
    }
    
    // MARK:- IBActions
    @IBAction private func managementButton_Tapped() {
        slideMenuController()?.closeLeft()
        let managementViewController = UIStoryboard.loadManagementViewController()
        (slideMenuController()?.mainViewController as! UINavigationController).pushViewController(managementViewController, animated: true)
    }
    
    @IBAction private func governingBodyButton_Tapped() {
        slideMenuController()?.closeLeft()
        let governingBodyViewController = UIStoryboard.loadGoverningBodyViewController()
        (slideMenuController()?.mainViewController as! UINavigationController).pushViewController(governingBodyViewController, animated: true)
    }
    
    @IBAction private func socialButton_Tapped(button: UIButton) {
        slideMenuController()?.closeLeft()
        let webUrlString = ["https://www.facebook.com/sjccblr", "https://www.linkedin.com/in/sjcc-s-657a01138/", "https://twitter.com/sjccblr", "https://www.youtube.com/channel/UC69_-P77nf5-rKrjcpVEsqQ"][button.tag]
        let webViewController = UIStoryboard.loadWebViewController()
        webViewController.webUrlString = webUrlString
        (slideMenuController()?.mainViewController as! UINavigationController).pushViewController(webViewController, animated: true)
    }
    
    @IBAction private func loginButton_Tapped() {
        guard !UserDefaults.standard.bool(forKey: Constant.UserDefaults.isStaffLoggedIn) else {
            return
        }
        let window = UIApplication.shared.keyWindow!
        let popUpHolderView = UIView(frame: window.bounds)
        popUpHolderView.tag = 999
        window.addSubview(popUpHolderView)
        
        let dismissButton = UIButton(frame: popUpHolderView.frame)
        dismissButton.addTarget(self, action: #selector(MenuViewController.dismissPopUp), for: .touchUpInside)
        popUpHolderView.addSubview(dismissButton)
        popUpHolderView.backgroundColor = UIColor.init(white: 0, alpha: 0.6)
        
        let loginView = UIView(frame: CGRect(x: 50, y: 50, width: screenWidth-80, height: 200))
        loginView.center = window.center
        loginView.backgroundColor = UIColor.white
        loginView.layer.cornerRadius = 4.0
        popUpHolderView.addSubview(loginView)
        
        userNameField = UITextField(frame: CGRect(x: 16, y: 22, width: screenWidth-112, height: 40))
        userNameField?.placeholder = "Enter Password"
        userNameField?.textAlignment = .center
        userNameField?.borderStyle = .line
        userNameField?.becomeFirstResponder()
        
        passwordField = UITextField(frame: CGRect(x: 16, y: 78, width: screenWidth-112, height: 40))
        passwordField?.placeholder = "Enter Password"
        passwordField?.textAlignment = .center
        passwordField?.borderStyle = .line
        passwordField?.isSecureTextEntry = true
        
        loginView.addSubview(userNameField!)
        loginView.addSubview(passwordField!)
        
        let loginButton = UIButton(frame: CGRect(x: screenWidth/2-100, y: 142, width: 100, height: 40))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "HoeflerText-Regular", size: 17)
        loginButton.backgroundColor = rgba(red: 235, green: 235, blue: 235)
        loginButton.layer.cornerRadius = 4.0
        loginButton.setTitleColor(UIColor.init(white: 0, alpha: 0.7), for: .normal)
        loginButton.addTarget(self, action: #selector(MenuViewController.authenticateFirebase), for: .touchUpInside)
        loginView.addSubview(loginButton)
    }
}
