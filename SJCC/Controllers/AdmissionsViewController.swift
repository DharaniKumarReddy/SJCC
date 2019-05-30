//
//  AdmissionsViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 10/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class AdmissionsViewController: UIViewController {

    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
    }
    
    @IBAction private func prospectUs_Tapped() {
        let prospectUsViewController = UIStoryboard.loadProspectUsViewController()
        navigationController?.pushViewController(prospectUsViewController, animated: true)
    }
    
    @IBAction private func ugButton_Tapped() {
        pushWebViewController("http://sjcc.edu.in/admission_procedure.php")
    }
    
    @IBAction private func pgButton_Tapped() {
        pushWebViewController("http://sjcc.edu.in/admission_procedure.php")
    }
    
    @IBAction private func pgdButton_Tapped() {
        pushWebViewController("http://sjcc.edu.in/admission_procedure.php")
    }
}
