//
//  PostDetailInteractor.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class PostDetailInteractor: PostDetailInteractorInput {
    
    weak var output: PostDetailInteractorOutput!
    var postsService: VKPostsService!
    var likesService: VKLikesService!

    // MARK: - PostDetailInteractorInput
    
    func loadPost(_ post: Post) {
        
        let _ = postsService.getPost(post) { (result) in
            self.output?.didLoadPost(with: result)
        }
    }
    
    func likePost(_ post: Post) {
        
        let _ = likesService.likeItem(with: .post, ownerId: post.ownerId, itemId: post.postId, ownerType: post.ownerType, accessKey: nil) { (result) in
            self.output?.didLikePost(with: result)
        }
    }
    
    func unlikePost(_ post: Post) {
        
        let _ = likesService.unlikeItem(with: .post, ownerId: post.ownerId, itemId: post.postId, ownerType: post.ownerType, accessKey: nil) { (result) in
            self.output?.didUnlikePost(with: result)
        }
    }
}
