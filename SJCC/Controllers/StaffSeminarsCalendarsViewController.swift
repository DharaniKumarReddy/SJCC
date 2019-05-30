//
//  StaffSeminarsCalendarsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 22/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import EventKit
import Toast_Swift

class StaffSeminarsCalendarsViewController: UIViewController {

    // MARK:- Variables
    private var seminars: [NewsLetter] = []
    
    private var calendars: [StaffCalendar] = []
    
    private var remainders: [ParentsAnnouncement] = []
    
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
        
        if index == 1 {
            getStaffRemainders()
        } else if index == 4 {
            getStaffSeminars()
        } else {
            getStaffCalendars()
        }
    }
    
    // MARK:- Private Methods
    private func getStaffRemainders() {
        APICaller.getInstance().getStaffRemainderAnnouncementList(onSuccess: { remainders in
            self.remainders = remainders
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getStaffSeminars() {
        APICaller.getInstance().getStaffSeminarList(onSuccess: { seminars in
            self.seminars = seminars
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
    
    private func getStaffCalendars() {
        APICaller.getInstance().getStaffAcademicCalendar(onSuccess: { calendars in
            self.calendars = calendars
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }, onError: {_ in})
    }
}

extension StaffSeminarsCalendarsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index == 1 ? remainders.count : index == 4 ? seminars.count : calendars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SeminarCalendarTableCell.self)) as? SeminarCalendarTableCell
        let date = index == 1 ? remainders[indexPath.row].date : index == 4 ? seminars[indexPath.row].date : calendars[indexPath.row].date
        let title = index == 1 ? remainders[indexPath.row].title : index == 4 ? seminars[indexPath.row].title : calendars[indexPath.row].title
        cell?.loadData(date: date, title: title, buttonTitle: index == 1 ? "View / Download" : "Add To Calendar")
        cell?.tag = indexPath.row
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}

extension StaffSeminarsCalendarsViewController: EventCreationProtocol {
    func createEvent(index: Int, title: String?) {
        if title == "View / Download" {
            pushWebViewController(remainders[index].pdf)
        } else {
            let eventStore : EKEventStore = EKEventStore()
            
            // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
            
            eventStore.requestAccess(to: .event) { (granted, error) in
                
                if (granted) && (error == nil) {
                    print("granted \(granted)")
                    print("error \(String(describing: error))")
                    
                    let event = EKEvent(eventStore: eventStore)
                    let title = self.index == 4 ? self.seminars[index].title : self.calendars[index].title
                    event.title = title
                    event.startDate = Date()
                    event.endDate = Date().addingTimeInterval(60.0 * 60.0)
                    event.notes = "Event created by SJCC"
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let error as NSError {
                        print("failed to save event with error : \(error)")
                    }
                    DispatchQueue.main.async{
                        self.view.makeToast("Event Added To Calendar", duration: 1.0, position: .center)
                    }
                } else {
                     print("failed to save event with error : \(String(describing: error)) or access not granted")
                }
            }
        }
    }
}

class SeminarCalendarTableCell: UITableViewCell {
    fileprivate var delegate: EventCreationProtocol?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    fileprivate func loadData(date: String, title: String, buttonTitle: String) {
        dateLabel.text = date
        titleLabel.text = title
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    @IBAction private func addToCalendarButton_Tapped() {
        delegate?.createEvent(index: tag, title: actionButton.titleLabel?.text)
    }
}

protocol EventCreationProtocol: class {
    func createEvent(index: Int, title: String?)
}
