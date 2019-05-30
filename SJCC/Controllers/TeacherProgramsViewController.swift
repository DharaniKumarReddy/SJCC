//
//  TeacherProgramsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 06/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class TeacherProgramsViewController: UIViewController {

    // MARK:- Variables
    var isTeacherMeetings = false
    
    var meetings: [TeacherMeeting] = []
    
    var outReachPrograms: [News] = []
    
    // MARK:- IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        tableView.estimatedRowHeight = isTeacherMeetings ? 300 : 100
        tableView.rowHeight = UITableView.automaticDimension
        if isTeacherMeetings {
            getParentsTeachersMeetings()
        } else {
            getOutreachPrograms()
        }
    }
    
    // MARL:- Private Methods
    private func getParentsTeachersMeetings() {
        APICaller.getInstance().getParentsTeachersMettingList(onSuccess: { meetings in
            self.meetings = meetings
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getOutreachPrograms() {
        APICaller.getInstance().getOutreachPrograms(onSuccess: { programs in
            self.outReachPrograms = programs
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension TeacherProgramsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTeacherMeetings ? meetings.count : outReachPrograms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isTeacherMeetings {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeacherMeetingTableCell.self)) as? TeacherMeetingTableCell
            cell?.loadData(meeting: meetings[indexPath.row])
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OutReachProgramTableCell.self)) as? OutReachProgramTableCell
            cell?.loadData(program: outReachPrograms[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
}

class TeacherMeetingTableCell: UITableViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    internal func loadData(meeting: TeacherMeeting) {
        dateLabel.text = meeting.date
        titleLabel.text = meeting.title
        descriptionLabel.text = meeting.description
    }
}

class OutReachProgramTableCell: UITableViewCell {
    @IBOutlet private weak var newsImageView: UIImageView!
    @IBOutlet private weak var newsDateLabel: UILabel!
    @IBOutlet private weak var newsTitleLabel: UILabel!
    @IBOutlet private weak var newsDescriptionLabel: UILabel!
    
    internal func loadData(program: News?) {
        newsImageView.downloadImageFrom(link: program?.image ?? "", contentMode: .scaleAspectFill)
        newsDateLabel.text = program?.date
        newsTitleLabel.text = program?.title
        newsDescriptionLabel.text = program?.description
    }
}
