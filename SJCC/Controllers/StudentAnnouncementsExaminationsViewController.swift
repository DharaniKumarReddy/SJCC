//
//  StudentAnnouncementsExaminationsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 24/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StudentAnnouncementsExaminationsViewController: UIViewController {

    // MARK:- Variables
    private var data: [ParentsAnnouncement] = []
    
    internal var index = 0
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        if index == 0 {
            getStudentAnnouncement()
        } else if index == 1 {
            getStudentExaminations()
        } else {
            getStudentDownloads()
        }
    }
    
    // MARK:- Private Methods
    private func getStudentAnnouncement() {
        APICaller.getInstance().getStudentAnnouncements(onSuccess: { announcements in
            self.data = announcements
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getStudentExaminations() {
        APICaller.getInstance().getStudentExaminations(onSuccess: { examinations in
            self.data = examinations
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getStudentDownloads() {
        APICaller.getInstance().getStudentDownloads(onSuccess: { downloads in
            self.data = downloads
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension StudentAnnouncementsExaminationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsAnnouncementsTableCell.self)) as? ParentsAnnouncementsTableCell
        cell?.pdfDelegate = self
        cell?.loadData(announcement: data[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension StudentAnnouncementsExaminationsViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(data[id].pdf)
    }
}
