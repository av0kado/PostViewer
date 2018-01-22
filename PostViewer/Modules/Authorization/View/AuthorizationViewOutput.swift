//
//  AuthorizationViewOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol AuthorizationViewOutput {
	
    /// Signalize that view is loaded
    func viewIsReady()
    
    /// View `authorize` button pressed
    func authorizePressed()
}
