
//
//  BackgroundLayer.swift
//
//  Created by wangyutao on 2018/10/25.
//

import Foundation

class BackgroundLayer: CALayer {
    
    let separator: CALayer = {
        let sep = CALayer()
        sep.backgroundColor = UIColor.hex(0xdbdbdb).cgColor
        return sep
    }()
    
    override init() {
        super.init()
        addSublayer(separator)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var frame: CGRect {
        didSet {
            let pixel = 1.0 / UIScreen.main.scale
            separator.frame = CGRect(x: 0, y: frame.size.height - pixel, width: frame.size.width, height: pixel)
        }
    }
}
