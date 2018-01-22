//
//  PostsListInteractorInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostsListInteractorInput {
    
    /// Log out current user
    func logOut()
    
    /// Get user feed
    func loadFeed(withOffset offset: String?)
    
    /// Cancel loading feed
    func cancelLoadingFeed()
}
