//
//  UIColor+HexFormatColor.swift
//  CryptoWallet
//
//  Created by Назар Ткаченко on 18.04.2023.
//

import UIKit.UIColor

enum Colors {
    
    case onboardBackground
    case onboardDescriptionText
    case onboardHeaderText
    case onboardDisablePoint
    case onboadrCurrentPoint
    case registerButton
    case white
    case background
    case indexCoin
    case tabBarItemOn
    case tabBarItemOff
    case gradientDarkGrey
    case gradientLightGrey
    
    // MARK: - Properties
    var uiColor: UIColor {
        switch self {
        case .onboardBackground:
            return hexStringToUIColor(hex: "FFF9E7")
        case .onboardDescriptionText:
            return hexStringToUIColor(hex: "566286")
        case .onboardHeaderText:
            return hexStringToUIColor(hex: "808080")
        case .onboardDisablePoint:
            return hexStringToUIColor(hex: "878FA9")
        case .onboadrCurrentPoint:
            return hexStringToUIColor(hex: "566286")
        case .registerButton:
            return hexStringToUIColor(hex: "191C32")
        case .white:
            return hexStringToUIColor(hex: "FFFFFF")
        case .background:
            return hexStringToUIColor(hex: "F3F5F6")
        case .indexCoin:
            return hexStringToUIColor(hex: "9395A4")
        case .tabBarItemOn:
            return hexStringToUIColor(hex: "26273C")
        case .tabBarItemOff:
            return hexStringToUIColor(hex: "CED0DE")
        case .gradientDarkGrey:
            return hexStringToUIColor(hex: "C9C9C9")
        case .gradientLightGrey:
            return hexStringToUIColor(hex: "EFF1FF")
        }
    }
}

extension Colors {
    private func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

