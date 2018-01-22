//
//  PostsListModuleLoader.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostsListModuleLoader: BaseModuleLoader {
    
    lazy var storyboardsFactory: StoryboardsFactory = StoryboardsFactoryImplementation()

    // MARK: - BaseModuleConfigurator

    override func configureModule(for view: UIViewController) {

        let viewController = view as! PostsListViewController

        let router = PostsListRouter()
        router.presentationView = view
        router.authorizationModuleLoader = AuthorizationModuleLoader()
        router.postDetailModuleLoader = PostDetailModuleLoader()
        router.alertsFactory = CommonAlertsFactoryImplementation()

        let presenter = PostsListPresenter()
        presenter.view = viewController
        presenter.router = router
        presenter.dataSourceFactory = PostsListCellDataSourceFactoryImplementation()

        let interactor = PostsListInteractor()
        interactor.output = presenter
        interactor.authorizationService = VKAuthorizationServiceImplementation()
        interactor.feedService = VKFeedServiceImplementation()

        presenter.interactor = interactor
        viewController.output = presenter
    }

    // MARK: - BaseModuleLoader

    override func loadModuleViewController() -> UIViewController {
        let controller = storyboardsFactory.getStoryboard(with: .posts).instantiateViewController(with: .postsList)
        return controller
    }

}
