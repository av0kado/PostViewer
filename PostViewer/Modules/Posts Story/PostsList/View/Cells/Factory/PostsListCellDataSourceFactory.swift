//
//  PostsListCellDataSourceFactory.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

typealias PostsListCellDataSourceConfiguration = (dataSource: TableViewDataSource, selectionItems: [String : Post])

protocol PostsListCellDataSourceFactory {

    func buildDataSource(with posts: [Post], preferredWidth: Int?) -> PostsListCellDataSourceConfiguration
}
