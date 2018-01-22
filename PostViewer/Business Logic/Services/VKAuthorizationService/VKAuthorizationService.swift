//
//  VKAuthorizationService.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// User authorization state
///
/// - authorized: user is authorized
/// - unauthorized: user is not authorized or did log out
/// - processing: user is in state of authorizing, but not yet authorized
enum VKAuthorizationState {
    case authorized
    case unauthorized
    case processing
}

enum VKAuthorizationResult {
    case success()
    case failure(PostViewerError)
}

enum VKDeauthorizationResult {
    case success()
    case failure(PostViewerError)
}

/// Service for authorization with VK
protocol VKAuthorizationService {
    
    /// Get current authorizationState
    func currentAuthorizationState() -> VKAuthorizationState
    
    /// Authorize with VK
    func authorize(withCompletion completion: @escaping (VKAuthorizationResult) -> Void)
    
    /// Deauthorize from VK
    func logOut(withCompletion completion: @escaping (VKDeauthorizationResult) -> Void)
}
