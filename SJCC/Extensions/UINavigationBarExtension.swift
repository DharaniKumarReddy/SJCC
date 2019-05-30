//
//  UINavigationBarExtension.swift
//  SJCC
//
//  Created by Dharani Reddy on 01/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func transparentBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HoeflerText-Black", size: iPhoneSE ? 15 : iPhoneStandard ? 18 : 20)!]
    }
}
