//
//  UIStackView+DSL.swift
//  Swiftesla
//
//  Created by xudongzhang on 2019/8/30.
//

import UIKit

@available(iOS 9.0, *)
public extension UIStackView {
    
    @discardableResult
    func set(baselineRelative arrangement: Bool) -> Self {
        isBaselineRelativeArrangement = arrangement
        return self
    }
    
    @discardableResult
    func set(layoutMarginsRelative arrangement: Bool) -> Self {
        isLayoutMarginsRelativeArrangement = arrangement
        return self
    }
    
    @discardableResult
    func set(axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }
    
   
    @discardableResult
    func set(distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
   
    @discardableResult
    func set(alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    @discardableResult
    func set(spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    @discardableResult
    func addArrangedSubviews(_ items: UIView...) -> Self {
        if items.isEmpty { return self }
        for i in 0..<items.count {
            addArrangedSubview(items[i])
        }
        return self
    }
    
}
