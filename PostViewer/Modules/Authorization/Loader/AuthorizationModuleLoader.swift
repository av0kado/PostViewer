//
//  AuthorizationModuleLoader.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class AuthorizationModuleLoader: BaseModuleLoader {
    
    lazy var storyboardsFactory: StoryboardsFactory = StoryboardsFactoryImplementation()

    // MARK: - BaseModuleConfigurator

    override func configureModule(for view: UIViewController) {

        let viewController = view as! AuthorizationViewController

        let router = AuthorizationRouter()
        router.presentationView = view
        router.postsListModuleLoader = PostsListModuleLoader()
        router.alertsFactory = CommonAlertsFactoryImplementation()

        let presenter = AuthorizationPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AuthorizationInteractor()
        interactor.output = presenter
        interactor.authorizationService = VKAuthorizationServiceImplementation()

        presenter.interactor = interactor
        viewController.output = presenter
    }

    // MARK: - BaseModuleLoader

    override func loadModuleViewController() -> UIViewController {
        let controller = storyboardsFactory.getStoryboard(with: .authorization).instantiateInitialViewController()!
        return controller
    }

}
