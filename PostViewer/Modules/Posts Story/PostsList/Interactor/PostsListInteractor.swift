//
//  PostsListInteractor.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class PostsListInteractor: PostsListInteractorInput {

    weak var output: PostsListInteractorOutput!
    var authorizationService: VKAuthorizationService!
    var feedService: VKFeedService!
    
    var feedLoadingTask: CancelableRequest?
    var wasCanceled: Bool = false

    // MARK: - PostsListInteractorInput
    
    func logOut() {
        authorizationService.logOut { (result) in
            self.output?.didLogOut(with: result)
        }
    }
    
    func loadFeed(withOffset offset: String?) {
        if feedLoadingTask != nil {
            return
        }
        wasCanceled = false
        
        feedLoadingTask = feedService.getUserFeed(withLimit: 20, offset: offset) { [weak self] (result) in
            self?.feedLoadingTask = nil
            
            switch result {
            case .failure(let error):
                if error.isCancelled || self?.wasCanceled == true {
                    return
                }
            default:
                break
            }
            
            self?.output.didFinishLoadingFeed(with: result)
        }
    }
    
    func cancelLoadingFeed() {
        wasCanceled = true
        feedLoadingTask?.cancel()
    }
}
