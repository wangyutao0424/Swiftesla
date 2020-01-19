//
//  BaseViewController.swift
//
//  Created by wangyutao on 2018/1/11.
//  Copyright © 2018年 GJGroup. All rights reserved.
//

import Foundation

/// navbar的类型，提供3个常用的类型，后2个可以根据自己需要设置
///
/// - white: 白色navbar
/// - transparent: 透明navbar
/// - color: 自定义颜色，关联参数为UIColor
/// - image: 自定义image，关联参数为UIImage
public enum BarStyle {
    case white
    case transparent
    case color(UIColor)
    case image(UIImage?)
}

/// VC的基类，用来处理navbar的各种问题
open class BaseViewController: UIViewController {
    
    public lazy var navbar: NavBar = {
        var bar = NavBar(barStyle: NavBar.default.barStyle, vc: self)
        return bar
    }()
    
    public enum AppearState {
        case disAppear
        case willAppear
        case appear
        case willDisappear
    }

    var appearState = AppearState.disAppear

    public init() {
        super.init(nibName: nil, bundle: nil)
        defaultInit()
    }

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        defaultInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultInit()
    }
    
    func defaultInit() {
        self.hidesBottomBarWhenPushed = true
        modalPresentationStyle = .fullScreen
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appearState = .willAppear
        if let parent = self.parent ,
            (!(parent is UINavigationController) && !(parent is UITabBarController)) {
            return
        }
        navbar.refresh(animated: true)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearState = .appear
//        enablePopGesture()
        if let parent = self.parent ,
            (!(parent is UINavigationController) && !(parent is UITabBarController)) {
            return
        }
        let block = {
            self.navbar.refresh(animated: false)
        }
        if #available(iOS 11.0, *) {
            block()
        }
        else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appearState = .willDisappear
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        appearState = .disAppear
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return navbar.statusBarStyle
    }
    
    @objc open func popBack() {
        guard let nav = self.navigationController else { return }
        if nav.viewControllers.count > 1 {
            nav.popViewController(animated: true)
        } else if let _ = nav.presentingViewController{
            nav.dismiss(animated: true, completion: nil)
        }
    }
    
    /// 调用顺序：
    /// viewDidLoad
    /// viewWillAppear
    /// viewDidLayoutSubviews 并且在viewDidAppear后也会调用，消失时也会调用
    /// viewDidAppear
    /// viewDidLayoutSubviews
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navbar.layoutBGLayer()
    }

}

//extension BaseViewController: UIGestureRecognizerDelegate {
//    func enablePopGesture() {
//        if let nav = navigationController{
//            nav.interactivePopGestureRecognizer?.delegate = self;
//        }
//    }
//    
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        if navigationController?.viewControllers.count == 1 {
//            return false;
//        }
//        return true;
//    }
//}

// MARK: - config
extension BaseViewController {
    /// 启动时调用这个进行初始化
    static public func config() {
        let apearance = UINavigationBar.appearance()
        apearance.isTranslucent = true //透明,必须是透明，不可更改，改了出问题活该
        apearance.barTintColor = .clear
        apearance.shadowImage = UIImage()
        apearance.setBackgroundImage(UIImage(), for: .default)
    }
}
