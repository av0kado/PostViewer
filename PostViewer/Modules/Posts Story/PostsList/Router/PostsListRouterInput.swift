//
//  PostsListRouterInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostsListRouterInput {
    
    /// Presents Authorization module
    func presentAuthorizationScreen()
    
    /// Presents alert view with given title
    func presentCommonAlert(with title: String)
    
    /// Presents post detail module
    ///
    /// - Parameter post: post to present
    func presentPostDetail(with post: Post)
}
