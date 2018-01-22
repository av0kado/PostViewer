//
//  PostsListCellDataSourceFactoryImplementation.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class PostsListCellDataSourceFactoryImplementation: PostsListCellDataSourceFactory {

    // MARK: - PostsListCellDataSourceFactory
    
    func buildDataSource(with posts: [Post], preferredWidth: Int?) -> PostsListCellDataSourceConfiguration {
        let dataStructure = TableViewDataSourceStructure()
        
        var selectionItems = [String : Post]()
        var cellObjects = [CellObject]()
        
        for post in posts.filter({ $0.owner != nil }).enumerated() {
            
            let itemId = String(post.offset)
            let post = post.element
            
            if !(post.owner is User) && !(post.owner is Group) {
                continue
            }
            
            var ownerName: String
            var avatar: Avatar
            
            if let postOwner = post.owner as? User {
                ownerName = "\(postOwner.firstName) \(postOwner.lastName)"
                avatar = postOwner.avatar
            } else {
                let postOwner = post.owner as! Group
                ownerName = postOwner.name
                avatar = postOwner.avatar
            }
            
            var imagesLayout: ImagesLayout?
            if let images = post.images {
                imagesLayout = ImagesLayout(with: images)
            }
            
            let cellObject = PostsListPostCellObject(itemId: itemId, ownerName: ownerName, avatar: avatar, date: post.date, imagesLayout: imagesLayout, likesCount: post.likes, isLiked: post.isLiked)
            cellObjects.append(cellObject)
            selectionItems[itemId] = post
            
            if let preferredWidth = preferredWidth {
                let _ = cellObject.height(for: preferredWidth)
            }
            
            let spaceCellObject = PostsListSpaceCellObject()
            cellObjects.append(spaceCellObject)
        }
        
        dataStructure.appendSection(with: cellObjects)
        
        let dataSource = TableViewDataSource(with: dataStructure)
        return (dataSource, selectionItems)
    }
}
