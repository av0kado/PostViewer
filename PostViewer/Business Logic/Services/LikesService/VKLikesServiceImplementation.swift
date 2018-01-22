//
//  VKLikesServiceImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

class VKLikesServiceImplementation: VKLikesService {

    // MARK: - LikesService
    
    func likeItem(with type: LikedObjectType, ownerId: Int, itemId: Int, ownerType: OwnerType, accessKey: String?, completion: @escaping LikesServiceCallback) -> CancelableRequest {
        
        let parameters = getParameters(with: type, ownerId: ownerId, itemId: itemId, ownerType: ownerType, accessKey: accessKey)
        
        let task = VK.API.Likes
            .add(parameters)
            .onSuccess { (data) in
                let result = self.handleData(data)
                completion(result)
            }.onError { (vkError) in
                completion(.failure(PostViewerError(vkError: vkError)))
            }.send()
        
        return SwiftyVKCancelableTask(task)
    }
    
    func unlikeItem(with type: LikedObjectType, ownerId: Int, itemId: Int, ownerType: OwnerType, accessKey: String?, completion: @escaping LikesServiceCallback) -> CancelableRequest {
        
        let parameters = getParameters(with: type, ownerId: ownerId, itemId: itemId, ownerType: ownerType, accessKey: accessKey)
        
        let task = VK.API.Likes
            .delete(parameters)
            .onSuccess { (data) in
                let result = self.handleData(data)
                completion(result)
            }.onError { (vkError) in
                completion(.failure(PostViewerError(vkError: vkError)))
            }.send()
        
        return SwiftyVKCancelableTask(task)
    }
    
    // MARK: - Helpers
    
    private func getParameters(with type: LikedObjectType, ownerId: Int, itemId: Int, ownerType: OwnerType, accessKey: String?) -> Parameters {
        
        var ownerId = ownerId
        if ownerType == .group {
            ownerId = -ownerId
        }
        
        let parameters: Parameters = [.type : type.rawValue,
                                      .ownerId : String(ownerId),
                                      .itemId : String(itemId)]
        return parameters
    }
    
    func handleData(_ data: Data) -> LikesServiceResult {
        
        guard let json = data.jsonDictionary(), let likes = json["likes"] as? Int else {
            return .failure(.serializationError)
        }
        
        return .success(likes)
    }
}
