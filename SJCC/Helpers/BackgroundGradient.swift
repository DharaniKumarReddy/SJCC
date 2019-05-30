//
//  BackgroundGradient.swift
//  SJCC
//
//  Created by Dharani Reddy on 06/04/19.
//  Copyright © 2019 Integro Infotech. All rights reserved.
//

import Foundation
import UIKit

let screenWidth     = UIScreen.main.bounds.width
let screenHeight    = UIScreen.main.bounds.height
let iPhoneSE        = UIScreen.main.bounds.width == 320
let iPhoneStandard  = UIScreen.main.bounds.width == 375

var topSareArea: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 20
        } else {
            return 20
        }
    }
}

var bottomSafeArea: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            return 0
        }
    }
}

class BlueGradientColorView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(getGradientLayer(width: screenWidth, height: topSareArea+44), at: 0)
    }
}

class TabBlueGradientColorView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(getGradientLayer(width: screenWidth, height: 60), at: 0)
    }
}

class BackGroundBlueGradient: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(getGradientLayer(width: screenWidth-screenWidth/5, height: screenHeight), at: 0)
    }
}

class DashboardBlueGradient: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(getGradientLayer(width: screenWidth, height: screenHeight), at: 0)
    }
}

class WhiteGradientLayer: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(getWhiteGradientLayer(), at: 0)
    }
}

private func getGradientLayer(width: CGFloat, height: CGFloat) -> CAGradientLayer {
    
    let colorTop = rgba(red: 184, green: 185, blue: 185).cgColor
    let colorBottom = rgba(red: 64, green: 175, blue: 220).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 1.0]
    
    return gradientLayer
}

func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, a: CGFloat? = 1.0) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: a ?? 1.0)
}

private func getWhiteGradientLayer() -> CAGradientLayer {
    let colorTop = rgba(red: 255, green: 255, blue: 255, a: 0).cgColor
    let colorBottom = rgba(red: 255, green: 255, blue: 255, a: 0.5).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70)
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.locations = [0.0, 1.0]
    
    return gradientLayer
}
