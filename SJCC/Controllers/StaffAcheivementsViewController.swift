//
//  StaffAcheivementsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 23/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StaffAcheivementsViewController: UIViewController {

    // MARK:- Variables
    private var acheivements: [StaffAcheivement] = []
    
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
        getStaffAcheivements()
    }
    
    // MARK:- Private Methods
    private func getStaffAcheivements() {
        APICaller.getInstance().getStaffAcheivementList(onSuccess: { acheivements in
            self.acheivements = acheivements
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension StaffAcheivementsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acheivements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StaffAcheivementsTableCell.self)) as? StaffAcheivementsTableCell
        cell?.loadData(acheivement: acheivements[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

class StaffAcheivementsTableCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var designationLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    fileprivate func loadData(acheivement: StaffAcheivement) {
        photoImageView.downloadImageFrom(link: acheivement.image, contentMode: .scaleAspectFill)
        titleLabel.text = acheivement.name
        designationLabel.text = acheivement.designation
        descriptionLabel.text = acheivement.description
    }
}
