//
//  UIViewController+.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/06.
//

import UIKit

extension UIViewController {

    /// 最前面に表示中のViewControllerを取得する
    static func getFrontViewController(
        vc: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
    ) -> UIViewController? {
        if let navigationController = vc as? UINavigationController {
            return getFrontViewController(vc: navigationController.visibleViewController)
        }
        if let tabBarController = vc as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return getFrontViewController(vc: selectedViewController)
        }
        if let presentedViewController = vc?.presentedViewController {
            return getFrontViewController(vc: presentedViewController)
        }
        return vc
    }
}
