//
//  UILabelExtension.swift
//  SJCC
//
//  Created by Dharani Reddy on 09/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

class DashboardLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont(name: "HoeflerText-Regular", size: iPhoneSE ? 16 : iPhoneStandard ? 19 : 21)
    }
}

class DashboardBoldLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = UIFont(name: "HoeflerText-Black", size: iPhoneSE ? 15 : iPhoneStandard ? 17 : 19)
    }
}
