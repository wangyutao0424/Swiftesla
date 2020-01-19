//
//  Title.swift
//  BaseViewController
//
//  Created by wangyutao on 2018/10/25.
//

import Foundation


public class NavBar {
    
    /// 启动时可以设置这个默认配置，
    public struct Default {
        /// 作为默认navbar默认颜色，默认为白色
        public var barStyle: BarStyle = .color(.white)
        /// 是否有navBar下面的分割线
        public var hasSeparator: Bool = true
        /// navBar上title的字体
        public var titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    }
    
    public static var `default` = Default()
    
    unowned private let vc: BaseViewController
    
    public var hidesBackButton = false {
        didSet {
            refreshPopBackItem()
        }
    }
    
    public var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            vc.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    /// bar是否隐藏
    /// 如果vc没在界面上，只设置状态，待展示时触发
    /// 若VC在界面上，则直接触发
    public var isHidden: Bool = false {
        didSet {
            if vc.appearState == .disAppear {
                return
            }
            refresh(animated: true)
        }
    }
    
    /// 是否展示分割线，barStyle改变会影响，只有白色barStyle才会设成true
    public var hasSeparator: Bool = NavBar.default.hasSeparator  {
        didSet {
            if vc.appearState == .disAppear {
                 return
            }
            bgLayer.separator.isHidden = !hasSeparator
        }
    }
    
    /// 自己画上去的navbar 背景，上面的颜色都是设在这个view上
    let bgLayer: BackgroundLayer = {
        let layer = BackgroundLayer()
        layer.zPosition = 1
        return layer
    }()
    
    /// 刷新navBar
    /// viewWillAppear，设置属性等事件会触发此方法，真正的去使用NavBar的属性去刷新
    /// 刷新范围：
    /// 1，系统NavBar
    /// 2，CALayer Navbar背景，及下面的分割线
    /// 3，返回按钮
    func refresh(animated: Bool) {
        vc.navigationController?.setNavigationBarHidden(isHidden, animated: animated)
        vc.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        refreshBGLayer()
        refreshPopBackItem()
    }
    
    //处理是否展示（add layer）
    private func refreshBGLayer() {
        if bgLayer.superlayer == nil && vc.navigationController != nil {
            vc.view.layer.addSublayer(bgLayer)
        }
        bgLayer.isHidden = isHidden
        bgLayer.separator.isHidden = !hasSeparator
    }
    
    func layoutBGLayer() {
        var height: CGFloat = 64
        if #available(iOS 11.0, *), vc.view.responds(to: #selector(getter: UIView.safeAreaInsets)) {
            height = vc.view.safeAreaInsets.top
        } else {
            height = vc.topLayoutGuide.length
        }
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        bgLayer.frame = CGRect(x: 0, y: 0, width: vc.view.bounds.size.width, height: height)
        CATransaction.commit()
    }
    
    /// 改变navbar背景的alpha值，不用一遍一遍改barStyle
    public var bgAlpha: Float {
        set {
            bgLayer.opacity = newValue
        }
        get {
            return bgLayer.opacity
        }
    }
    
    /// bar的类型，改变他会影响以下几点：1，返回按钮颜色（需回调给vc设置），2，title颜色，3分割线颜色
    public var barStyle: BarStyle {
        didSet {
            config(barStyle: barStyle)
            refreshPopBackItem()
        }
    }

    /// title颜色，会根据barStyle做改变，当barStyle为白色，默认为黑色，其他情况均为白色
    public var titleColor: UIColor = {
        if case BarStyle.white = NavBar.default.barStyle  {
            return .hex(0x444444)
        }
        return .white
    }() {
        didSet {
            if vc.appearState != .disAppear {
                vc.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
            }
        }
    }

    /// title字体，默认13号字
    public var titleFont: UIFont = NavBar.default.titleFont
    
    var titleTextAttributes: [NSAttributedString.Key : Any] {
        return [.foregroundColor: titleColor,
                .font: titleFont]
    }
    
    init(barStyle: BarStyle, vc: BaseViewController) {
        self.barStyle = barStyle
        self.vc = vc
        config(barStyle: barStyle)
        bgLayer.separator.isHidden = !hasSeparator
    }
    
    private func config(barStyle: BarStyle) {
        switch barStyle {
        case .white:
            hasSeparator = true
            titleColor = .hex(0x444444)
            statusBarStyle = .default
        default:
            hasSeparator = false
            titleColor = .white
            statusBarStyle = .lightContent
        }
        refreshNavBarBackground()
    }
    
    /// 背景只有style会影响
    private func refreshNavBarBackground(){
        var img: UIImage?
        switch barStyle {
        case .white:
            img = UIImage.image(color: .white)
        case .transparent:
            img = UIImage()
        case .color(let color):
            img = UIImage.image(color: color)
        case .image(let image):
            img = image
        }
        bgLayer.contents = img?.cgImage
    }
    
    func refreshPopBackItem() {
    
        guard let nav = vc.navigationController, nav.viewControllers.count > 1, !hidesBackButton else {
            vc.navigationItem.leftBarButtonItem = nil
            vc.navigationItem.hidesBackButton = true
            return
        }
        addBackLeftItemButton()
    }
        
    public func addBackLeftItemButton() {
        let popbackImgName: String
        switch barStyle {
        case .white:
            popbackImgName = "popback_black"
        default:
            popbackImgName = "vc_popback"
            break
        }
        let image = UIImage(named: popbackImgName)?.withRenderingMode(.alwaysOriginal)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image , style: .plain, target: vc, action: #selector(BaseViewController.popBack))
    }
}

extension UIImage {
    class func image(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 320, height: 44)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
    }
}
