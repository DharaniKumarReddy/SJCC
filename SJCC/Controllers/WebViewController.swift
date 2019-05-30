//
//  WebViewController.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 29/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    internal var webUrlString: String?
    
    var webView: WKWebView!
    
    // MARK:- IBOutlets
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: topSareArea+44, width: screenWidth, height: screenHeight-(topSareArea+44)), configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.sizeToFit()
        view.insertSubview(webView, at: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
        navigationBarViewHeightConstant.constant = topSareArea+44
        let myURL = URL(string: webUrlString ?? "")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
