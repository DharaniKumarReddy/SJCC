//
//  NewsLetterViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 10/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class NewsLetterViewController: UIViewController {

    // MARK:- Varibales
    var newsLetters: [NewsLetter] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        getNewsLetterList()
    }
    
    private func getNewsLetterList() {
        APICaller.getInstance().getNewsLetter(onSuccess: {letters in
            self.newsLetters = letters
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension NewsLetterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsLetters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsLetterTableCell.self)) as? NewsLetterTableCell
        cell?.pdfDelegate = self
        cell?.loadData(newsLetter: newsLetters[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension NewsLetterViewController: ViewPDFDelegate {
    func loadUrlPDF(id: Int) {
        pushWebViewController(newsLetters[id].pdf)
    }
}

class NewsLetterTableCell: UITableViewCell {
    internal weak var pdfDelegate: ViewPDFDelegate?
    @IBOutlet private weak var newsLetterDateLabel: UILabel!
    @IBOutlet private weak var newsLetterTitleLabel: UILabel!
    @IBOutlet private weak var newsLetterImageView: UIImageView!
    
    internal func loadData(newsLetter: NewsLetter) {
        newsLetterImageView.downloadImageFrom(link: newsLetter.image, contentMode: .scaleAspectFill)
        newsLetterDateLabel.text = newsLetter.date
        newsLetterTitleLabel.text = newsLetter.title
    }
    
    @IBAction private func viewPDFButton_Tapped() {
        pdfDelegate?.loadUrlPDF(id: tag)
    }
}

protocol ViewPDFDelegate: class {
    func loadUrlPDF(id: Int)
}
