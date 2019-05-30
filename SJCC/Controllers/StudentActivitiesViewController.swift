//
//  StudentActivitiesViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 24/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StudentActivitiesViewController: UIViewController {

    // MARK:- Variables
    private var activitiesWrites: [News] = []
    
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        index == 2 ? getStudentActivities() : getStudentSjccWrites()
    }
    
    // MARK:- Private Methods
    private func getStudentActivities() {
        APICaller.getInstance().getStudentActivites(onSuccess: {activities in
            self.activitiesWrites = activities
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getStudentSjccWrites() {
        APICaller.getInstance().getStudentSjccWrites(onSuccess: { writes in
            self.activitiesWrites = writes
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension StudentActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitiesWrites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ActivitiesTableCell.self)) as? ActivitiesTableCell
        cell?.loadData(activityWrite: activitiesWrites[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

class ActivitiesTableCell: UITableViewCell {
    @IBOutlet private weak var activityImageView: UIImageView!
    @IBOutlet private weak var activityTitleLabel: UILabel!
    @IBOutlet private weak var activityDateLabel: UILabel!
    @IBOutlet private weak var activityDescriptionLabel: UILabel!
    
    fileprivate func loadData(activityWrite: News) {
        activityImageView.downloadImageFrom(link: activityWrite.image, contentMode: .scaleAspectFill)
        activityTitleLabel.text = activityWrite.title
        activityDateLabel.text = activityWrite.date
        activityDescriptionLabel.text = activityWrite.description
    }
}
