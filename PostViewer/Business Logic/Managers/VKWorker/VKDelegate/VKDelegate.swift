//
//  VKDelegate.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import SwiftyVK

class VKDelegate: SwiftyVKDelegate {
    
    private let appId = "6337946"
    private let scopes: Scopes = [.wall, .friends]
    
    weak var output: VKDelegateOutput!
    
    init() {
        VK.setUp(appId: appId, delegate: self)
    }
    
    func vkNeedsScopes(for sessionId: String) -> Scopes {
        
        return scopes
    }
    
    func vkNeedToPresent(viewController: VKViewController) {
        
        output.vkWantsToPresentController(viewController)
    }
    
    func vkTokenCreated(for sessionId: String, info: [String : String]) {
        print("token created in session \(sessionId) with info \(info)")
    }
    
    func vkTokenUpdated(for sessionId: String, info: [String : String]) {
        print("token updated in session \(sessionId) with info \(info)")
    }
    
    func vkTokenRemoved(for sessionId: String) {
        print("token removed in session \(sessionId)")
    }
}
