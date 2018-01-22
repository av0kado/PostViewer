//
//  SplashScreenRouterInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol SplashScreenRouterInput {
    
    /// Navigates to authorization module
    func presentAuthorizationModule()
    
    /// Navigates to posts list
    func presentPostsList()
}
