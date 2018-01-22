//
//  SplashScreenPresenter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class SplashScreenPresenter: SplashScreenViewOutput, SplashScreenInteractorOutput {

    weak var view: SplashScreenViewInput!
    var interactor: SplashScreenInteractorInput!
    var router: SplashScreenRouterInput!
    
    // MARK: - SplashScreenViewOutput
    
    func viewIsReady() {
        view.setupInitialState()
        interactor.getAuthorizationState()
    }

    // MARK: - SplashScreenInteractorOutput

    func didGetAuthorizationState(_ state: VKAuthorizationState) {
        switch state {
        case .authorized:
            router.presentPostsList()
        case .processing, .unauthorized:
            router.presentAuthorizationModule()
        }
    }
}
