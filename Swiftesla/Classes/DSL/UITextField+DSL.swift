//
//  UITextField+DSL.swift
//  Swiftesla
//
//  Created by xudongzhang on 2018/9/13.
//

import Foundation

public extension UITextField {
    
    @discardableResult
    func text(_ text: String) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString) -> Self {
        self.attributedText = text
        return self
    }
    

    @discardableResult
    func placeholder(_ text: String) -> Self {
        placeholder = text
        return self
    }
    
    @discardableResult
    func attributedPlaceholder(_ text: NSAttributedString) -> Self {
        attributedPlaceholder = text
        return self
    }

    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
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
    func delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }

}
