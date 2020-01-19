//
//  UIColor+Extention.swift
//  Swiftesla
//
//  Created by wangyutao on 2018/3/29.
//

import UIKit

extension UIColor {
    static let colorComponentMax: Float = 255.0
    static let colorComponentMin: Float = 0.0

    static func colorWithHex(color: Int, alpha: Float = 1) -> UIColor {
        return hex(color: color, alpha: alpha)
    }

    static func hex(_ color: Int, alpha: Float = 1) -> UIColor {
        return hex(color: color, alpha: alpha)
    }

    static func hex(color: Int, alpha: Float = 1) -> UIColor {
        let redComponet: Float = Float(color >> 16)
        let greenComponent: Float = Float((color & 0xFF00) >> 8)
        let blueComponent: Float = Float(color & 0xFF)
        return UIColor(red: CGFloat(redComponet / UIColor.colorComponentMax), green: CGFloat(greenComponent / UIColor.colorComponentMax), blue: CGFloat(blueComponent / UIColor.colorComponentMax), alpha: CGFloat(alpha))
    }

    static func colorWith(red: Int, green: Int, blue: Int) -> UIColor {
        var lRed = Float(red)
        var lGreen = Float(green)
        var lBlue = Float(blue)
        UIColor.checkRange(colorComponent: &lRed)
        UIColor.checkRange(colorComponent: &lGreen)
        UIColor.checkRange(colorComponent: &lBlue)
        return UIColor(red: CGFloat(lRed / UIColor.colorComponentMax), green: CGFloat(lGreen / UIColor.colorComponentMax), blue: CGFloat(lBlue / UIColor.colorComponentMax), alpha: 1.0)
    }

    static func checkRange(colorComponent: inout Float) {
        if colorComponent > UIColor.colorComponentMax {
            colorComponent = UIColor.colorComponentMax
        }

        if colorComponent < UIColor.colorComponentMin {
            colorComponent = UIColor.colorComponentMin
        }
    }

    static func randomColor() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
