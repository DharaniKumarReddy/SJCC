//
//  StaffViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 19/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StaffViewController: UIViewController {

    let staffItems = ["Leave Status / Apply for Leave", "Meeting Reminders / Announcements",
                      "Academic Calender", "Staff Achievements", "Conference / Seminar Alerts ",
                      "Staff Duties", "Service Rules & Regulations", "Salary Slips"]
    
    // MARK:- IBOutlets
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
    }
}

extension StaffViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staffItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsTableCell.self)) as? ParentsTableCell
        cell?.parentsNotesLabel.text = staffItems[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 5,6:
            let staffRulesViewController = UIStoryboard.loadStaffRulesViewController()
            staffRulesViewController.isRules = indexPath.row == 6
            navigationController?.pushViewController(staffRulesViewController, animated: true)
        case 1, 2, 4:
            let staffSeminarCalendarController = UIStoryboard.loadStaffSeminarsCalendarsViewController()
            staffSeminarCalendarController.index = indexPath.row
            navigationController?.pushViewController(staffSeminarCalendarController, animated: true)
        case 0, 7:
            let staffRequestsViewController = UIStoryboard.loadStaffRequestsViewConytoller()
            staffRequestsViewController.isLeaveApply = indexPath.row == 0
            navigationController?.pushViewController(staffRequestsViewController, animated: true)
        case 3:
            let staffAcheivementsViewController = UIStoryboard.loadStaffAcheivementsViewController()
            navigationController?.pushViewController(staffAcheivementsViewController, animated: true)
        default:
            break
        }
    }
}
