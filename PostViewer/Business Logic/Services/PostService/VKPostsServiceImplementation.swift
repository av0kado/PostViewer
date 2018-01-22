//
//  VKPostsServiceImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

class VKPostsServiceImplementation: VKPostsService {

    // MARK: - PostService
    
    func getPost(_ post: Post, completion: @escaping (PostsServiceResult) -> Void) -> CancelableRequest? {
        
        var postsString: String
        if post.ownerType == .group {
            postsString = "-\(post.ownerId)_\(post.postId)"
        } else {
            postsString = "\(post.ownerId)_\(post.postId)"
        }
        
        let parameters: [Parameter : String] = [.posts : postsString,
                                                .extended : "1",
                                                .fields : "photo_100"]
        
        let task = VK.API.Wall
            .getById(parameters)
            .onSuccess { (data) in
                let result = self.handleData(data)
                completion(result)
            }.onError { (vkError) in
                completion(.failure(PostViewerError(vkError: vkError)))
            }.send()
        
        return SwiftyVKCancelableTask(task)
    }
    
    // MARK: - Private
    
    func handleData(_ data: Data) -> PostsServiceResult {
        
        guard let json = data.jsonDictionary(),
            let items = json["items"] as? [[String : Any]],
            let profiles = json["profiles"] as? [[String : Any]],
            let groupsJson = json["groups"] as? [[String : Any]] else {
                
                return .failure(.serializationError)
        }
        
        let news = JSONMapper<MappablePost>().mapArray(jsonArray: items)
        let users = JSONMapper<MappableUser>().mapArray(jsonArray: profiles)
        let groups = JSONMapper<MappableGroup>().mapArray(jsonArray: groupsJson)
        
        return .success((posts: news, users: users, groups: groups))
    }
}
