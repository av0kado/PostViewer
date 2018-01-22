//
//  PostsListRouter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostsListRouter: PostsListRouterInput {

    weak var presentationView: UIViewController!
    var authorizationModuleLoader: BaseModuleLoader!
    var postDetailModuleLoader: BaseModuleLoader!
    var alertsFactory: CommonAlertsFactory!

    // MARK: - PostsListRouterInput
    
    func presentAuthorizationScreen() {
        
        let controller = authorizationModuleLoader.loadModuleViewController()
        UIApplication.appDelegate.setNewRootViewController(controller)
    }
    
    func presentPostDetail(with post: Post) {
        
        let controller = postDetailModuleLoader.loadModuleViewController()
        
        if let configurableController = controller as? ConfigurableModuleController {
            configurableController.configureModule(with: post)
        }
        
        presentationView.navigationController?.pushViewController(controller, animated: true)
    }
    
    func presentCommonAlert(with title: String) {
        
        let controller = alertsFactory.buildAlert(with: title)
        presentationView.present(controller, animated: true, completion: nil)
    }
}
