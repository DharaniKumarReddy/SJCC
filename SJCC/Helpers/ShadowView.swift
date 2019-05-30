//
//  ShadowView.swift
//  SJCC
//
//  Created by Dharani Reddy on 12/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.cornerRadius = 4.0
    }
}
