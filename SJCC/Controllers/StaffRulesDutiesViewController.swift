//
//  StaffRulesViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 22/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StaffRulesDutiesViewController: UIViewController {

    // MARK:- Variables
    private var rules: [TeacherMeeting] = []
    
    private var duties: [NewsLetter] = []
    
    internal var isRules = false
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = isRules ? UITableView.automaticDimension : 130
        if isRules {
            getStaffRules()
        } else  {
            getStaffDuties()
        }
    }
    
    private func getStaffRules() {
        APICaller.getInstance().getStaffRulesList(onSuccess: { rules in
            self.rules = rules
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getStaffDuties() {
        APICaller.getInstance().getStaffDutiesList(onSuccess: { duties in
            self.duties = duties
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension StaffRulesDutiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isRules ? rules.count : duties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isRules {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeacherMeetingTableCell.self)) as? TeacherMeetingTableCell
            cell?.loadData(meeting: rules[indexPath.row])
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsLetterTableCell.self)) as? NewsLetterTableCell
            cell?.pdfDelegate = self
            cell?.loadData(newsLetter: duties[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
}

extension StaffRulesDutiesViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(duties[id].pdf)
    }
}
