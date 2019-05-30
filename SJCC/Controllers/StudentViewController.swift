//
//  StudentViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 24/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    let studentItems = ["Announcements", "Examinations", "Student Activities", "Placement Cell", "Downloads", "Sjcc Writes", "Complaint Registry", "Feedback"]
    
    // MARK:- IBOutlets
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
    }
}

extension StudentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsTableCell.self)) as? ParentsTableCell
        cell?.parentsNotesLabel.text = studentItems[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0, 1, 4:
           let announcementExaminationController = UIStoryboard.loadStudentAnnouncementExaminationsViewController()
           announcementExaminationController.index = indexPath.row
           navigationController?.pushViewController(announcementExaminationController, animated: true)
        case 2, 5:
            let studentActivitiesViewController = UIStoryboard.loadStudentActivitiesViewController()
            studentActivitiesViewController.index = indexPath.row
            navigationController?.pushViewController(studentActivitiesViewController, animated: true)
        case 3:
            let studentPlacementsViewController = UIStoryboard.loadStudentPlacementsViewController()
            navigationController?.pushViewController(studentPlacementsViewController, animated: true)
        case 6, 7:
            pushWebViewController(["", "", "", "", "", "", "http://sjcc.edu.in/sjcc_app/complaint_registry.php", "http://sjcc.edu.in/sjcc_app/student_feedback.php"][indexPath.row])
        default:
            break
        }
    }
}
