//
//  VKAuthorizationServiceImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

class VKAuthorizationServiceImplementation: VKAuthorizationService {

    // MARK: - VKAuthorizationService
    
    func currentAuthorizationState() -> VKAuthorizationState {
        
        let vkState = VK.sessions.default.state
        
        switch vkState {
        case .authorized:
            return .authorized
        case .destroyed:
            return .unauthorized
        case .initiated:
            return .processing
        }
    }
    
    func authorize(withCompletion completion: @escaping (VKAuthorizationResult) -> Void) {
        
        VK.sessions.default.logIn(onSuccess: { (dictionary) in
            print(dictionary)
            completion(.success())
        }) { (vkError) in
            completion(.failure(PostViewerError(vkError: vkError)))
        }
    }
    
    func logOut(withCompletion completion: @escaping (VKDeauthorizationResult) -> Void) {
        
        VK.sessions.default.logOut()
        completion(.success())
    }
}
