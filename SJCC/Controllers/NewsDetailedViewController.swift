//
//  NewsDetailedViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 01/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class NewsDetailedViewController: UIViewController {

    // MARK:- Variables
    internal var news: News?
    private var activityController : UIActivityViewController!
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        navigationBarViewHeightConstant.constant = topSareArea+44
        title = "St. Joseph's College of Commerce"
        navigationBackWithNoText()
        navigationController?.transparentBar()
        loadActivityController(id: news?.id ?? "")
    }
    
    private func loadActivityController(id: String) {
        let url = URL(string: "http://sjcc.edu.in/sjcc_app/newsshare.php?id=\(id)")!
        activityController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityController.excludedActivityTypes = [.print, .copyToPasteboard, .assignToContact, .saveToCameraRoll, .addToReadingList]
    }
}

extension NewsDetailedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsDetailedTableCell.self)) as? NewsDetailedTableCell
        cell?.loadData(newsDetails: news)
        return cell ?? UITableViewCell()
    }
}

extension NewsDetailedViewController: ShareDelegate {
    func shareData(tag: Int) {
        present(activityController, animated: true, completion: nil)
    }
}

class NewsDetailedTableCell: UITableViewCell {
    fileprivate weak var delegate: ShareDelegate?
    
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    
    fileprivate func loadData(newsDetails: News?) {
        newsImageView.downloadImageFrom(link: newsDetails?.image ?? "", contentMode: .scaleAspectFill)
        newsDateLabel.text = newsDetails?.date
        newsTitleLabel.text = newsDetails?.title
        newsDescriptionLabel.text = newsDetails?.description
    }
    
    @IBAction private func shareButton_Tapped() {
        delegate?.shareData(tag: tag)
    }
}

protocol ShareDelegate: class {
    func shareData(tag: Int)
}
