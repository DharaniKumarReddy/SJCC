//
//  ProspectUsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 12/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class ProspectUsViewController: UIViewController {

    // MARK:- Varibales
    var list: [NewsLetter] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        getProspectUsList()
    }
    
    private func getProspectUsList() {
        APICaller.getInstance().getProspectUsList(onSuccess: {list in
            self.list = list
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension ProspectUsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsLetterTableCell.self)) as? NewsLetterTableCell
        cell?.pdfDelegate = self
        cell?.loadData(newsLetter: list[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension ProspectUsViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(list[id].pdf)
    }
}
