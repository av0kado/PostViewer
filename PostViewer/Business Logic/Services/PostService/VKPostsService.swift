//
//  VKPostsService.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

typealias PostsResult = (posts: [Post], users: [User], groups: [Group])

enum PostsServiceResult {
    case success(PostsResult)
    case failure(PostViewerError)
}

/// Service for loading wall posts
protocol VKPostsService {
    
    /// Loads post by given post
    ///
    /// - Parameters:
    ///   - post: post to load
    ///   - completion: completion handler
    /// - Returns: cancelable request
    func getPost(_ post: Post, completion: @escaping (PostsServiceResult) -> Void) -> CancelableRequest?
}
