//
//  PostDetailViewInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

protocol PostDetailViewInput: class {
    
    /// Setup view's initial state
    func setupInitialState()
    
    // Configure with post owner
    func setPostOwner(_ user: User)
    func setPostOwner(_ group: Group)
    
    /// Configure view with provided data
    ///
    /// - Parameters:
    ///   - postDate: date of post
    ///   - text: text of post
    ///   - images: images of post
    func set(postDate: Date, text: String?, images: [AttachmentImage]?)
    
    /// Sets likes and user liked for post
    ///
    /// - Parameters:
    ///   - likesCount: likes count
    ///   - isLiked: post is liked
    func setLikes(_ likesCount: Int, isLiked: Bool)
    
    /// Set post deleted
    func setPostDeleted()
}
