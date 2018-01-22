//
//  VKFeedServiceImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

class VKFeedServiceImplementation: VKFeedService {

    // MARK: - VKFeedService
    
    func getUserFeed(withLimit limit: Int, offset: String?, completion: @escaping FeedServiceCallback) -> CancelableRequest? {
        
        var parameters: [Parameter : String] = [.filters : "post",
                                                .count : String(limit)]
        
        if let offset = offset {
            parameters[.startFrom] = offset
        }
        
        let task = VK.API.NewsFeed
            .get(parameters)
            .onSuccess { (data) in
                let result = self.handleFeedData(data)
                completion(result)
            }.onError { (vkError) in
                completion(.failure(PostViewerError(vkError: vkError)))
            }.send()
        
        return SwiftyVKCancelableTask(task)
    }
    
    // MARK: - Private
    
    /// Process data to result
    ///
    /// - Returns: serialized data
    func handleFeedData(_ data: Data) -> FeedServiceResult {
        
        guard let json = data.jsonDictionary(),
            let items = json["items"] as? [[String : Any]],
            let profiles = json["profiles"] as? [[String : Any]],
            let groupsJson = json["groups"] as? [[String : Any]],
            let offset = json["next_from"] as? String else {
                
            return .failure(.serializationError)
        }
        
        let news = JSONMapper<MappablePost>().mapArray(jsonArray: items)
        let users = JSONMapper<MappableUser>().mapArray(jsonArray: profiles)
        let groups = JSONMapper<MappableGroup>().mapArray(jsonArray: groupsJson)
        
        return .success((posts: news, users: users, groups: groups, offset: offset))
    }
}
