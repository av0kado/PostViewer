//
//  PostsListPresenter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

class PostsListPresenter: PostsListViewOutput, PostsListInteractorOutput {

    enum LoadingState {
        case nothing
        case initialLoading
        case isRefreshing
        case isLoadingMore
    }
    
    weak var view: PostsListViewInput!
    var interactor: PostsListInteractorInput!
    var router: PostsListRouterInput!
    
    var dataSourceFactory: PostsListCellDataSourceFactory!
    
    lazy var backgroundQueue = DispatchQueue(label: "PostsList.Presenter.Background")
    
    var selectionItems: [String : Post] = [:]
    var currentOffset: String?
    var posts: [Post] = []
    var users: Set<User> = []
    var groups: Set<Group> = []
    var currentState: LoadingState = .nothing
    
    // MARK: - PostsListViewOutput
    
    func viewIsReady() {
        currentState = .initialLoading
        view.setupInitialState()
        interactor.loadFeed(withOffset: currentOffset)
    }

    func logOutPressed() {
        interactor.cancelLoadingFeed()
        interactor.logOut()
    }
    
    func didSelectPost(with id: String) {
        guard let post = selectionItems[id] else {
            return
        }
        router.presentPostDetail(with: post)
    }
    
    func didRefresh() {
        if currentState == .isRefreshing {
            return
        }
        
        interactor.cancelLoadingFeed()
        currentState = .isRefreshing
        interactor.loadFeed(withOffset: nil)
    }
    
    func loadMore() {
        if currentState == .isRefreshing || currentState == .isLoadingMore {
            return
        }
        
        currentState = .isLoadingMore
        interactor.loadFeed(withOffset: currentOffset)
    }
    
    // MARK: - PostsListInteractorOutput

    func didLogOut(with result: VKDeauthorizationResult) {
        router.presentAuthorizationScreen()
    }
    
    func didFinishLoadingFeed(with result: FeedServiceResult) {
        let currentState = self.currentState
        
        switch result {
        case .success(posts: let posts, users: let users, groups: let groups, offset: let offset):
            
            if currentState == .isRefreshing {
                self.posts = []
                self.users = []
                self.groups = []
            }
            self.posts.append(contentsOf: posts)
            
            for user in users {
                self.users.insert(user)
            }
            for group in groups {
                self.groups.insert(group)
            }
            currentOffset = offset
            
            backgroundQueue.async {
                guard let view = self.view else {
                    return
                }
                
                self.findUsersForPosts()
                let dataSourceConfiguration = self.dataSourceFactory.buildDataSource(with: self.posts, preferredWidth: view.getTableWidth())
                
                self.selectionItems = dataSourceConfiguration.selectionItems
                DispatchQueue.main.sync {
                    self.currentState = .nothing
                    
                    self.view?.presentTable(with: dataSourceConfiguration.dataSource)
                }
            }
            
        case .failure(let error):
            
            DispatchQueue.main.async {
                self.router.presentCommonAlert(with: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Helpers
    
    /// Adds owners to posts
    func findUsersForPosts() {
        
        for post in posts {
            if post.owner == nil {
                
                switch post.ownerType {
                case .group:
                    guard let groupIndex = groups.index(where: { (group) -> Bool in
                        group.id == post.ownerId
                    }) else {
                        continue
                    }
                    
                    let group = groups[groupIndex]
                    post.owner = group
                case .user:
                    guard let userIndex = users.index(where: { (user) -> Bool in
                        user.id == post.ownerId
                    }) else {
                        continue
                    }
                    
                    let user = users[userIndex]
                    post.owner = user
                }
            }
        }
    }
}
