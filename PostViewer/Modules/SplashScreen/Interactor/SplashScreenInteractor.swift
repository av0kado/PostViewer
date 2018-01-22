//
//  SplashScreenInteractor.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class SplashScreenInteractor: SplashScreenInteractorInput {

    weak var output: SplashScreenInteractorOutput!
    
    var authorizationService: VKAuthorizationService!

    // MARK: - SplashScreenInteractorInput
    
    func getAuthorizationState() {
        let status = authorizationService.currentAuthorizationState()
        output.didGetAuthorizationState(status)
    }
}
