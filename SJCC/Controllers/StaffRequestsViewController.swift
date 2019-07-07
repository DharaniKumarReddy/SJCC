//
//  StaffRequestsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 22/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import MessageUI
import Toast_Swift

class StaffRequestsViewController: UIViewController {

    // MARK:- Variables
    internal var isLeaveApply = false
    
    // MARK:- IBOutlets
    @IBOutlet private weak var reasonView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var toDatePicker: UIDatePicker!
    @IBOutlet private weak var fromDatePicker: UIDatePicker!
    @IBOutlet private weak var reasonTextView: UITextView!
    @IBOutlet private weak var toDateTextField: UITextField!
    @IBOutlet private weak var fromDateTextField: UITextField!
    @IBOutlet private weak var centerConstraint: NSLayoutConstraint!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        if !isLeaveApply {
            titleLabel.text = "Salary Slips"
            reasonView.removeFromSuperview()
        }
        if !isLeaveApply {
            centerConstraint.constant = 35
        }
        view.enableTapToDismissKeyboard()
        loadDatePickers()
    }
    
    // MARK:- Private Methods
    private func loadDatePickers() {
        toDateTextField.inputView = toDatePicker
        fromDateTextField.inputView = fromDatePicker
        fromDatePicker.minimumDate = Date().dateByAddingMonths(-12)
        toDatePicker.minimumDate = fromDatePicker.minimumDate
        fromDatePicker.maximumDate = Date().dateByAddingMonths(12)
        toDatePicker.maximumDate = fromDatePicker.maximumDate
    }
    
    private func sendEmail() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients(["principal@sjcc.edu.in", "avinash@sjcc.edu.in"])
        mailVC.setSubject(getMailSubject())
        mailVC.setMessageBody(getMailBody(), isHTML: false)
        present(mailVC, animated: true, completion: nil)
    }
    
    private func getMailBody() -> String {
        if isLeaveApply {
            return reasonTextView.text + " from " + fromDateTextField.text! + " to " + toDateTextField.text!
        } else {
            return "Salary slips from " + fromDateTextField.text! + " to " + toDateTextField.text!
        }
    }
    
    private func getMailSubject() -> String {
        return isLeaveApply ? "Leave Application" : "Salary Slips"
    }
    
    // MARK:- IBActions
    @IBAction private func fromDatePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter(dateFormat: "dd-MM-yyyy")
        fromDateTextField?.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction private func toDatePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter(dateFormat: "dd-MM-yyyy")
        toDateTextField?.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction private func sendEmailButton_Tapped() {
        guard fromDateTextField.text != "" && toDateTextField.text != "" && reasonTextView?.text != "Write the Reason" else {
            self.view.makeToast("Please fill all the details", duration: 1.0, position: .center)
            return
        }
        sendEmail()
    }
}

extension StaffRequestsViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Write the Reason" {
            textView.text = ""
            textView.textColor = .black
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write the Reason"
            textView.textColor = UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return text != "\n"
    }
}

extension StaffRequestsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField.text == "" else {
            return
        }
        textField.text = DateFormatter(dateFormat: "dd-MM-yyyy").string(from: Date())
    }
}

extension StaffRequestsViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
