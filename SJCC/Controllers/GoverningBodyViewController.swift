//
//  GoverningBodyViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 14/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class GoverningBodyViewController: UIViewController {

    // MARK:- Variables
    var governingBodies: [GoverningBody] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        getGoverningBodies()
    }
    
    private func getGoverningBodies() {
        APICaller.getInstance().getGoverningBodyList(onSuccess: { bodies in
            self.governingBodies = bodies
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension GoverningBodyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return governingBodies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ParentsTableCell.self)) as? ParentsTableCell
        cell?.parentsNotesLabel.text = governingBodies[indexPath.row].title
        return cell ?? UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        APICaller.getInstance().getGoverningIndividual(id: governingBodies[indexPath.row].id, onSuccess: {_ in}, onError: {_ in})
//    }
}
