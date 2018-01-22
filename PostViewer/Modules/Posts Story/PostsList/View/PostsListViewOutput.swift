//
//  PostsListViewOutput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostsListViewOutput {
	
    /// View is loaded and ready
    func viewIsReady()
    
    /// View pressed `Log Out`
    func logOutPressed()
    
    /// Selected cell with provided post id
    func didSelectPost(with id: String)
    
    /// Did refresh posts table
    func didRefresh()
    
    /// View is about to end
    func loadMore()
}
