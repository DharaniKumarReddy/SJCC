//
//  ParentsAnnouncementsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 05/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class ParentsAnnouncementsViewController: UIViewController {

    // MARK:- Variables
    var announcements: [ParentsAnnouncement] = []
    
    var basicModelData: [BasicModel] = []
    
    var isAnnouncements = false
    
    var isProgramActivity = false
    
    var isCollegeRules = false
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        if isAnnouncements {
            getAnnouncements()
        } else if isProgramActivity {
            getProgramActivity()
        } else {
            getCollegeRulesList()
        }
        if !isAnnouncements {
            tableView.estimatedRowHeight = 50
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    private func getAnnouncements() {
        APICaller.getInstance().getAnnouncementsList(onSuccess: { announcements in
            self.announcements = announcements
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getProgramActivity() {
        APICaller.getInstance().getProgramActivity(onSuccess: { data in
            self.basicModelData = data
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getCollegeRulesList() {
        APICaller.getInstance().getCollegeRules(onSuccess: { data in
            self.basicModelData = data
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension ParentsAnnouncementsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isAnnouncements ? announcements.count : basicModelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isAnnouncements {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsAnnouncementsTableCell.self)) as? ParentsAnnouncementsTableCell
            cell?.pdfDelegate = self
            cell?.loadData(announcement: announcements[indexPath.row])
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DescriptionCell.self)) as? DescriptionCell
            cell?.loadData(basicModel: basicModelData[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
}

extension ParentsAnnouncementsViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(announcements[id].pdf)
    }
}

class ParentsAnnouncementsTableCell: UITableViewCell {
    
    // MARK:- IBOutlets
    internal weak var pdfDelegate: ViewPDFDelegate?
    @IBOutlet private weak var announcementDateLabel: UILabel!
    @IBOutlet private weak var announcementTitleLabel: UILabel!
    
    internal func loadData(announcement: ParentsAnnouncement) {
        announcementDateLabel.text = announcement.date
        announcementTitleLabel.text = announcement.title
    }
    
    @IBAction private func viewPDFButton_Tapped() {
        pdfDelegate?.loadUrlPDF(id: tag)
    }
}

class DescriptionCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    fileprivate func loadData(basicModel: BasicModel) {
        titleLabel.text = basicModel.title
        descriptionLabel.text = basicModel.description
    }
    
    internal func loadManagementData(management: Management) {
        titleLabel.text = management.name
        descriptionLabel.text = management.designation
    }
}
