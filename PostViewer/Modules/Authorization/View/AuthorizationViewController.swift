//
//  AuthorizationViewController.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController, AuthorizationViewInput {
    
    var output: AuthorizationViewOutput!

    @IBOutlet weak var authorizeButton: UIButton!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Actions
    
    @objc func authorizeButtonPressed() {
        output.authorizePressed()
    }

    // MARK: - AuthorizationViewInput

    func setupInitialState() {
        authorizeButton.addTarget(self, action: #selector(authorizeButtonPressed), for: .touchUpInside)
    }
}
