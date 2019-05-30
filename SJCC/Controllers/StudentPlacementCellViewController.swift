//
//  StudentPlacementCellViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 24/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StudentPlacementCellViewController: UIViewController {

    // MARK:- Variables
    private var placements: [TeacherMeeting] = []
    
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
        tableView.rowHeight = UITableView.automaticDimension
        getStudentPlaceCell()
    }
    
    // MARK:- Private Methods
    private func getStudentPlaceCell() {
        APICaller.getInstance().getStudentPlacementCell(onSuccess: {placements in
            self.placements = placements
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension StudentPlacementCellViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeacherMeetingTableCell.self)) as? TeacherMeetingTableCell
        cell?.loadData(meeting: placements[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
