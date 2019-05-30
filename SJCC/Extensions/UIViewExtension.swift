//
//  UIViewExtension.swift
//  SJCC
//
//  Created by Dharani Reddy on 22/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func enableTapToDismissKeyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
        gestureRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(gestureRecognizer)
    }
}
