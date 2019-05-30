//
//  ManagementViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 14/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class ManagementViewController: UIViewController {

    // MARK:- Variables
    var managementList: [Management] = []
    
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
        getManagementList()
    }
    
    private func getManagementList() {
        APICaller.getInstance().getManagementList(onSuccess: { list in
            self.managementList = list
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension ManagementViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managementList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DescriptionCell.self)) as? DescriptionCell
        cell?.loadManagementData(management: managementList[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
