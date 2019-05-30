//
//  TopViewController.swift
//  Franziskaner Munchen
//
//  Created by Dharani Reddy on 30/09/18.
//  Copyright © 2018 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

class TopViewController {
    class func isNotifiedController() -> Bool {
        switch PushNotificationHandler.sharedInstance.notificationType {
        case 1:
            return UIApplication.topViewController() is DashboardViewController
        case 2:
            return UIApplication.topViewController() is AnnouncementsViewController
        case 3:
            return UIApplication.topViewController() is NewsLetterViewController
        case 4:
            return UIApplication.topViewController() is DashboardViewController
        default:
            return UIApplication.topViewController() is DashboardViewController
        }
    }
}
