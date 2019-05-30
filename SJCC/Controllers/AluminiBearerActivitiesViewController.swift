//
//  AluminiBearerActivitiesViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 09/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AluminiBearerActivitiesViewController: UIViewController {
    
    // MARK:- Variables
    var bearers: [OfficeBearer] = []
    
    var activities: [TeacherMeeting] = []
    
    var isBearers = false
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        if isBearers {
            tableView.rowHeight = 130
        } else {
            tableView.estimatedRowHeight = 200
            tableView.rowHeight = UITableView.automaticDimension
        }
        if isBearers {
            getAluminiOfficeBearers()
        } else {
            getAluminiAssociationActivities()
        }
    }
    
    private func getAluminiOfficeBearers() {
        APICaller.getInstance().getAluminiOfficeBeares(onSuccess: { bearers in
            self.bearers = bearers
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getAluminiAssociationActivities() {
        APICaller.getInstance().getAluminiAssociationActivities(onSuccess: { activities in
            self.activities = activities
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension AluminiBearerActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isBearers ? bearers.count : activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBearers {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AluminiBearersTableCell.self)) as? AluminiBearersTableCell
            cell?.loadData(bearer: bearers[indexPath.row])
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeacherMeetingTableCell.self)) as? TeacherMeetingTableCell
            cell?.loadData(meeting: activities[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
}

class AluminiBearersTableCell: UITableViewCell {
    @IBOutlet private weak var bearerImageView: UIImageView!
    @IBOutlet private weak var bearerTitleLabel: UILabel!
    @IBOutlet private weak var bearerDescriptionLabel: UILabel!
    
    fileprivate func loadData(bearer: OfficeBearer) {
        bearerImageView.downloadImageFrom(link: bearer.image, contentMode: .scaleAspectFill)
        bearerTitleLabel.text = bearer.name
        bearerDescriptionLabel.text = bearer.designation
    }
}
