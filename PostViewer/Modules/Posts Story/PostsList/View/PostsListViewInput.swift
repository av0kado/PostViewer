//
//  PostsListViewInput.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

protocol PostsListViewInput: class {
    
    /// Setup view's initial state
    func setupInitialState()
    
    /// Present tableView with provided dataSource
    func presentTable(with dataSource: TableViewDataSource)
    
    /// Returns width of tableView; need to calculate heights
    func getTableWidth() -> Int
}
