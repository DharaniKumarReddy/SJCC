//
//  ParentsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 04/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class ParentsViewController: UIViewController {

    // MARK:- Variables
    private let parentsNotes = ["Announcements", "Programs & Admission", "College Rules for Students", "Parent-Teacher Meetings", "Accessing Student Information", "Outreach Programs", "Feedback"]
    
    // MARK:- IBOutlets
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
    }
}

extension ParentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentsNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsTableCell.self)) as? ParentsTableCell
        cell?.parentsNotesLabel.text = parentsNotes[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            let parentsAnnouncementsViewController = UIStoryboard.loadParentsAnnouncementsViewController()
            parentsAnnouncementsViewController.isAnnouncements = indexPath.row == 0
            parentsAnnouncementsViewController.isProgramActivity = indexPath.row == 1
            parentsAnnouncementsViewController.isCollegeRules = indexPath.row == 2
            navigationController?.pushViewController(parentsAnnouncementsViewController, animated: true)
        } else if indexPath.row == 3 || indexPath.row == 5 {
            let teacherMeetingsViewController = UIStoryboard.loadTeacherProgramsViewController()
            teacherMeetingsViewController.isTeacherMeetings = indexPath.row == 3
            navigationController?.pushViewController(teacherMeetingsViewController, animated: true)
        }
    }
}

class ParentsTableCell: UITableViewCell {
    @IBOutlet internal var parentsNotesLabel: UILabel!
}
