//
//  SplashScreenRouter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class SplashScreenRouter: SplashScreenRouterInput {

    weak var presentationView: UIViewController!
    var authorizationModuleLoader: BaseModuleLoader!
    var postsListModuleLoader: BaseModuleLoader!

    // MARK: - SplashScreenRouterInput
    
    func presentAuthorizationModule() {
        let controller = authorizationModuleLoader.loadModuleViewController()
        UIApplication.appDelegate.setNewRootViewController(controller)
    }
    
    func presentPostsList() {
        let controller = postsListModuleLoader.loadModuleViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        UIApplication.appDelegate.setNewRootViewController(navigationController)
    }
}
