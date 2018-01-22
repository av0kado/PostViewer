//
//  PostDetailModuleLoader.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class PostDetailModuleLoader: BaseModuleLoader {
    
    lazy var storyboardsFactory: StoryboardsFactory = StoryboardsFactoryImplementation()

    // MARK: - BaseModuleConfigurator

    override func configureModule(for view: UIViewController) {

        let viewController = view as! PostDetailViewController

        let router = PostDetailRouter()
        router.presentationView = view
        router.alertsFactory = CommonAlertsFactoryImplementation()

        let presenter = PostDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = PostDetailInteractor()
        interactor.output = presenter
        interactor.postsService = VKPostsServiceImplementation()
        interactor.likesService = VKLikesServiceImplementation()

        presenter.interactor = interactor
        viewController.output = presenter
    }

    // MARK: - BaseModuleLoader

    override func loadModuleViewController() -> UIViewController {
        
        let controller = storyboardsFactory.getStoryboard(with: .posts).instantiateViewController(with: .postDetail)
        return controller
    }

}
