//
//  Post.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

/// Model of post in feed
class Post: Equatable {
    
    /// Id of post
    let postId: Int
    
    /// Id of post's owner
    let ownerId: Int
    
    /// Owner's type
    let ownerType: OwnerType
    
    /// Post owner
    var owner: Any?
    
    /// Date posted
    let date: Date
    
    /// Post text
    var text: String?
    
    /// Attachment images
    var images: [AttachmentImage]?
    
    /// Likes count
    var likes: Int
    
    /// Post liked or not
    var isLiked: Bool
    
    /// Basic initializer
    ///
    /// - Parameters:
    ///   - postId: post id
    ///   - ownerId: post owner id
    ///   - ownerType: post owner type
    ///   - date: post date
    ///   - text: post text
    ///   - images: post images attachments
    ///   - likes: post likes count
    ///   - isLiked: post is liked by user
    init(postId: Int, ownerId: Int, ownerType: OwnerType, date: Date, text: String? = nil, images: [AttachmentImage]? = nil, likes: Int = 0, isLiked: Bool = false) {
    
        self.postId = postId
        self.ownerId = ownerId
        self.ownerType = ownerType
        self.date = date
        self.text = text
        self.images = images
        self.likes = likes
        self.isLiked = isLiked
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return (lhs.ownerType == rhs.ownerType)
            && (lhs.ownerId == rhs.ownerId)
            && (lhs.postId == rhs.postId)
    }
}
