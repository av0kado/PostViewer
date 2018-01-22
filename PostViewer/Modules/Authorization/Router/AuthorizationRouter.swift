//
//  AuthorizationRouter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class AuthorizationRouter: AuthorizationRouterInput {

    weak var presentationView: UIViewController!
    var postsListModuleLoader: BaseModuleLoader!
    var alertsFactory: CommonAlertsFactory!

    // MARK: - AuthorizationRouterInput
    
    func presentPostsList() {
        
        let controller = postsListModuleLoader.loadModuleViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        UIApplication.appDelegate.setNewRootViewController(navigationController)
    }
    
    func presentCommonAlert(with title: String) {
        
        let controller = alertsFactory.buildAlert(with: title)
        presentationView.present(controller, animated: true, completion: nil)
    }
}
