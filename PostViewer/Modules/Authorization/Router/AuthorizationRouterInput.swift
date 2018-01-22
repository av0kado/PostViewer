//
//  AuthorizationRouterInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol AuthorizationRouterInput {
    
    /// Presents PostsList module
    func presentPostsList()
    
    /// Presents alert with OK button and provided text
    func presentCommonAlert(with title: String)
}
