//
//  AuthorizationPresenter.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

class AuthorizationPresenter: AuthorizationViewOutput, AuthorizationInteractorOutput {

    weak var view: AuthorizationViewInput!
    var interactor: AuthorizationInteractorInput!
    var router: AuthorizationRouterInput!
    
    // MARK: - AuthorizationViewOutput
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func authorizePressed() {
        interactor.beginAuthorization()
    }

    // MARK: - AuthorizationInteractorOutput

    func didFinishAuthorization(with result: VKAuthorizationResult) {
        switch result {
        case .success():
            
            DispatchQueue.main.async {
                self.router.presentPostsList()
            }
        case .failure(let error):
            
            DispatchQueue.main.async {
                self.router.presentCommonAlert(with: error.localizedDescription)
            }
        }
    }
}
