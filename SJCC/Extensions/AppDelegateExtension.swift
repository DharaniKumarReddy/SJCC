//
//  AppDelegateExtension.swift
//  SJCC
//
//  Created by Dharani Reddy on 18/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    internal class func getAppdelegate() -> AppDelegate? {
        return (UIApplication.shared.delegate as? AppDelegate)
    }
}
