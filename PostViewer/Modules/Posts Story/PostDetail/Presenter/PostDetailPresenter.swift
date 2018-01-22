//
//  PostDetailPresenter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

class PostDetailPresenter: PostDetailViewOutput, PostDetailInteractorOutput {

    weak var view: PostDetailViewInput!
    var interactor: PostDetailInteractorInput!
    var router: PostDetailRouterInput!
    
    var inputPost: Post?
    var currentPost: Post?
    
    // MARK: - PostDetailViewOutput
    
    func viewIsReady() {
        view.setupInitialState()
        
        guard let post = inputPost else {
            return
        }
        
        if let owner = post.owner as? User {
            view.setPostOwner(owner)
        } else if let owner = post.owner as? Group {
            view.setPostOwner(owner)
        }
        
        view.setLikes(post.likes, isLiked: post.isLiked)
        view.set(postDate: post.date, text: post.text, images: post.images)
    }
    
    func viewWillPresent() {
        guard let inputPost = inputPost else {
            return
        }
        
        interactor.loadPost(inputPost)
    }
    
    func configure(with post: Post) {
        
        inputPost = post
    }
    
    func like() {
        var post: Post! = currentPost
        
        if post == nil {
            post = inputPost
        }
        
        guard post != nil else {
            return
        }
        
        if post.isLiked == true {
            interactor.unlikePost(post)
        } else {
            interactor.likePost(post)
        }
    }
    
    func didUpdate() {
        
        guard let post = inputPost else {
            return
        }
        interactor.loadPost(post)
    }

    // MARK: - PostDetailInteractorOutput
    
    func didLoadPost(with result: PostsServiceResult) {
        
        switch result {
            
        case .success(posts: let posts, users: let users, groups: let groups):
            
            guard posts.count == 1 else {
                DispatchQueue.main.async {
                    self.view?.setPostDeleted()
                }
                return
            }
            
            let post = posts[0]
            
            switch post.ownerType {
            case .user:
                for user in users {
                    
                    if post.ownerId == user.id {
                        post.owner = user
                        break
                    }
                }
            case .group:
                for group in groups {
                    
                    if post.ownerId == group.id {
                        post.owner = group
                        break
                    }
                }
            }
            
            currentPost = post
            
            DispatchQueue.main.async {
                guard post.owner != nil else {
                    return
                }
                
                if post.ownerType == .group {
                    self.view?.setPostOwner(post.owner as! Group)
                } else {
                    self.view?.setPostOwner(post.owner as! User)
                }
                
                self.view?.setLikes(post.likes, isLiked: post.isLiked)
                self.view?.set(postDate: post.date, text: post.text, images: post.images)
            }
            
        case .failure(let error):
            
            DispatchQueue.main.async {
                self.router.presentCommonAlert(with: error.localizedDescription)
            }
        }
    }
    
    func didLikePost(with result: LikesServiceResult) {
        
        switch result {
        case .success(let likes):
            
            currentPost?.isLiked = true
            
            DispatchQueue.main.async {
                self.view?.setLikes(likes, isLiked: true)
            }
        default:
            break
        }
    }
    
    func didUnlikePost(with result: LikesServiceResult) {
        
        switch result {
        case .success(let likes):
            
            currentPost?.isLiked = false
            
            DispatchQueue.main.async {
                self.view?.setLikes(likes, isLiked: false)
            }
        default:
            break
        }
    }
}
