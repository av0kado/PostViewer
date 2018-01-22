//
//  RootViewControllerSetter.swift
//  Portable
//

import UIKit

extension AppDelegate {
    
    /// Sets new root view controller
    ///
    /// - Parameter viewController: view controller to be set as a new root view controller
    func setNewRootViewController(_ viewController: UIViewController) {
        
        window?.rootViewController = viewController
        
        guard let subviews: [UIView] = (window?.subviews) else {
            return
        }
        
        for subview: UIView in subviews {
            if subview.isKind(of: NSClassFromString("UITransitionView")!) {
                subview.removeFromSuperview()
            }
        }
    }
}
