//
//  SplashScreenModuleConfigurator.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class SplashScreenModuleConfigurator: BaseModuleConfigurator {
    
    lazy var storyboardsFactory: StoryboardsFactory = StoryboardsFactoryImplementation()

    // MARK: - BaseModuleConfigurator

    override func configureModule(for view: UIViewController) {

        let viewController = view as! SplashScreenViewController

        let router = SplashScreenRouter()
        router.presentationView = view
        router.authorizationModuleLoader = AuthorizationModuleLoader()
        router.postsListModuleLoader = PostsListModuleLoader()

        let presenter = SplashScreenPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = SplashScreenInteractor()
        interactor.output = presenter
        interactor.authorizationService = VKAuthorizationServiceImplementation()

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
