//
//  AnnouncementsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 12/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AnnouncementsViewController: UIViewController {

    // MARK:- Variables
    var announcements: [ParentsAnnouncement] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        getAnnouncements()
    }
    
    private func getAnnouncements() {
        APICaller.getInstance().getAnnouncements(onSuccess: { announcements in
            self.announcements = announcements
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension AnnouncementsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsAnnouncementsTableCell.self)) as? ParentsAnnouncementsTableCell
        cell?.pdfDelegate = self
        cell?.loadData(announcement: announcements[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension AnnouncementsViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(announcements[id].pdf)
    }
}
