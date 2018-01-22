//
//  PostDetailInteractorInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostDetailInteractorInput {

    /// Load post with parameters
    ///
    /// - Parameters:
    ///   - post: post to be loaded
    func loadPost(_ post: Post)
    
    /// Likes post
    ///
    /// - Parameter post: post to like
    func likePost(_ post: Post)
    
    /// Unlikes post
    ///
    /// - Parameter post: post to unlike
    func unlikePost(_ post: Post)
}
