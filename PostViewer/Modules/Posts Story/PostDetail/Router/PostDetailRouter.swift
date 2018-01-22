//
//  PostDetailRouter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostDetailRouter: PostDetailRouterInput {

    weak var presentationView: UIViewController!
    var alertsFactory: CommonAlertsFactory!

    // MARK: - PostDetailRouterInput
    
    func presentCommonAlert(with title: String) {
        
        let controller = alertsFactory.buildAlert(with: title)
        presentationView.present(controller, animated: true, completion: nil)
    }
}
