//
//  AluminiViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 09/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AluminiViewController: UIViewController {

    // MARK:- Variables
    var alumini = ["Alumni Association Office Bearers", "Alumni Association Activities", "Register"]
    
    // MARK:- IBOutlets
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
    }
}

extension AluminiViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alumini.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsTableCell.self)) as? ParentsTableCell
        cell?.parentsNotesLabel.text = alumini[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 2 else { return }
        let aluminiBearerActivitiesViewController = UIStoryboard.loadAluminiBearerActivitiesViewController()
        aluminiBearerActivitiesViewController.isBearers = indexPath.row == 0
        navigationController?.pushViewController(aluminiBearerActivitiesViewController, animated: true)
    }
}
