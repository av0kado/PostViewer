//
//  VKFeedService.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

typealias FeedResult = (posts: [Post], users: [User], groups: [Group], offset: String)

enum FeedServiceResult {
    case success(FeedResult)
    case failure(PostViewerError)
}

typealias FeedServiceCallback = (FeedServiceResult) -> Void

/// Service for loading feed
protocol VKFeedService {
    
    /// Get user feed
    ///
    /// - Parameters:
    ///   - limit: limit of news to load; up to 100
    ///   - offset: current offset; returned by result
    ///   - completion: completion handler
    /// - Returns: cancelable task
    func getUserFeed(withLimit limit: Int, offset: String?, completion: @escaping FeedServiceCallback) -> CancelableRequest?
}
