//
//  PostDetailViewOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 22/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostDetailViewOutput {
	
    /// View is ready for setup
    func viewIsReady()
    
    /// View is about to be presented
    func viewWillPresent()
    
    /// Configure module with input post
    func configure(with post: Post)
    
    /// User liked/disliked post
    func like()
    
    /// Update post
    func didUpdate()
}
