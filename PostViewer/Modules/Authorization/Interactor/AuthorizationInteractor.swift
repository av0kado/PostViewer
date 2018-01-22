//
//  AuthorizationInteractor.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class AuthorizationInteractor: AuthorizationInteractorInput {

    weak var output: AuthorizationInteractorOutput!
    
    var authorizationService: VKAuthorizationService!

    // MARK: - AuthorizationInteractorInput
    
    func beginAuthorization() {
        authorizationService.authorize { (result) in
            self.output?.didFinishAuthorization(with: result)
        }
    }
}
