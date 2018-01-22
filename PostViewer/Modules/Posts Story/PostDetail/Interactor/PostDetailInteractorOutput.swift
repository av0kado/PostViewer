//
//  PostDetailInteractorOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostDetailInteractorOutput: class {

    /// Interactor did finish loading post
    func didLoadPost(with result: PostsServiceResult)
    
    /// Did like post with result
    func didLikePost(with result: LikesServiceResult)
    
    /// Did unlike post with result
    func didUnlikePost(with result: LikesServiceResult)
}
