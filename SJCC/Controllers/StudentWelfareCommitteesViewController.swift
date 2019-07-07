//
//  StudentWelfareCommitteesViewController.swift
//  SJCC
//
//  Created by Dharani Reddy on 06/07/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import UIKit

class StudentWelfareCommitteesViewController: UIViewController {

    // MARK:_ IBOutlets
    @IBOutlet private weak var horizontalScrollView: UIScrollView!
    @IBOutlet private weak var navigationBarViewHeightConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarViewHeightConstant.constant = topSareArea+44
        navigationBackWithNoText()
        title = "St. Joseph's College of Commerce"
    }
    
    private func animateScrollView(point: CGPoint, shouldAnimate animate: Bool) {
        horizontalScrollView.setContentOffset(point, animated: animate)
    }
    
    // MARK:- IBActions
    @IBAction private func dismissButton_Tapped() {
        horizontalScrollView.isHidden = true
    }
    
    @IBAction private func viewImageButton_Tapped(button: UIButton) {
        animateScrollView(point: CGPoint(x: screenWidth*CGFloat(button.tag), y: 0), shouldAnimate: false)
        horizontalScrollView.isHidden = false
    }
    
    @IBAction private func swipeGestureRecognizer(gesture: UISwipeGestureRecognizer) {
        let currentXPoint = horizontalScrollView.contentOffset.x
        let xPoint = gesture.direction == .left ? currentXPoint+screenWidth : currentXPoint-screenWidth
        guard xPoint >= 0 && xPoint <= screenWidth*3 else { return }
        animateScrollView(point: CGPoint(x: xPoint, y: 0), shouldAnimate: true)
    }
}
