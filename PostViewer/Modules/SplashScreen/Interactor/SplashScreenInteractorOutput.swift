//
//  SplashScreenInteractorOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol SplashScreenInteractorOutput: class {
    
    /// Interactor did finish getting authorization state
    ///
    /// - Parameter state: state of user authorization
    func didGetAuthorizationState(_ state: VKAuthorizationState)
}
