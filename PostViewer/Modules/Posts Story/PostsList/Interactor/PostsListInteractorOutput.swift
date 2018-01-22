//
//  PostsListInteractorOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostsListInteractorOutput: class {

    /// Logged out with result
    func didLogOut(with result: VKDeauthorizationResult)
    
    /// Did finish loading feed with result
    func didFinishLoadingFeed(with result: FeedServiceResult)
}
