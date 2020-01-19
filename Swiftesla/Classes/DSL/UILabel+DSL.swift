//
//  UILabel+DSL.swift
//  Swiftesla
//
//  Created by xudongzhang on 2018/9/13.
//

import Foundation
public extension UILabel {
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult
    func line(_ number: Int) -> Self {
        numberOfLines = number
        return self
    }

    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }

    @discardableResult
    func attributedText(_ attributedText: NSAttributedString) -> Self {
        self.attributedText = attributedText
        return self
    }

    @discardableResult
    func textAlignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }

    @discardableResult
    func color(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    @discardableResult
    func color(_ hex: Int) -> Self {
        textColor = UIColor.hex(hex)
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func font(_ fontSize: Float) -> Self {
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }

    @discardableResult
    func font(_ fontSize: Int) -> Self {
        font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Float) -> Self {
        font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        return self
    }
    
    @discardableResult
    func boldFont(_ fontSize: Int) -> Self {
        font = UIFont.boldSystemFont(ofSize: CGFloat(fontSize))
        return self
    }
}
