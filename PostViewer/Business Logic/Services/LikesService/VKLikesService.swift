//
//  VKLikesService.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

enum LikedObjectType: String {
    case post
    case comment
    case photo
    case audio
    case video
    case note
    case market
    case photoComment = "photo_comment"
    case videoComment = "video_comment"
    case topicComment = "topic_comment"
    case marketComment = "market_comment"
}

enum LikesServiceResult {
    case success(Int)
    case failure(PostViewerError)
}

typealias LikesServiceCallback = (LikesServiceResult) -> Void

/// Service for liking/disliking
protocol VKLikesService {
    
    /// Likes item with given parameters
    ///
    /// - Parameters:
    ///   - type: item type
    ///   - ownerId: item owner id
    ///   - itemId: item id
    ///   - accessKey: item access key
    /// - Returns: cancelable task
    func likeItem(with type: LikedObjectType, ownerId: Int, itemId: Int, ownerType: OwnerType, accessKey: String?, completion: @escaping LikesServiceCallback) -> CancelableRequest
    
    /// Unlikes item with given parameters
    ///
    /// - Parameters:
    ///   - type: item type
    ///   - ownerId: item owner id
    ///   - itemId: item id
    ///   - accessKey: item access key
    /// - Returns: cancelable task
    func unlikeItem(with type: LikedObjectType, ownerId: Int, itemId: Int, ownerType: OwnerType, accessKey: String?, completion: @escaping LikesServiceCallback) -> CancelableRequest
}
