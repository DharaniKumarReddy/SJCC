//
//  UIStringExtension.swift
//  SFS COLLEGE
//
//  Created by Dharani Reddy on 25/01/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func downloadImage(completion: @escaping (UIImage) -> ()) {
        URLSession.shared.dataTask(with: NSURL(string:self)! as URL) {
            (data, response, error) in
            if let data = data {
                completion(UIImage(data: data) ?? #imageLiteral(resourceName: "default_image"))
            } else {
                completion(#imageLiteral(resourceName: "default_image"))
            }
            }.resume()
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}

func truncateCharactersInNotificationMessage(_ alertMessage:NSString) -> String {
    var message = alertMessage
    if message.length > 235 {
        message = message.substring(with: NSRange(location: 0, length: 235)) as NSString
    }
    return message as String
}
