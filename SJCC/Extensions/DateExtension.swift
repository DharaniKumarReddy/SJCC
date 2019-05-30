//
//  DateExtension.swift
//  SJCC
//
//  Created by Dharani Reddy on 23/05/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation

extension Date {
    func dateByAddingMonths(_ monthsToAdd: Int) -> Date? {
        
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        
        return (calendar as NSCalendar).date(byAdding: months, to: self, options: [])
    }
}
