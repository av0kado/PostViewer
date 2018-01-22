//
//  PostsListPostCellObject.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 21/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

class PostsListPostCellObject: CellObjectWithId {
    
    var itemId: String
    var ownerName: String
    var avatar: Avatar
    var date: Date
    var imagesLayout: ImagesLayout?
    var likesCount: Int
    var isLiked: Bool
    
    private var preferredWidth: Int? {
        didSet {
            preferredHeight = nil
        }
    }
    
    private var preferredHeight: Int?
    
    private var height: Int {
        if let preferredHeight = preferredHeight {
            return preferredHeight
        }
        
        guard let preferredWidth = preferredWidth else {
            fatalError("Can't work without preferred width")
        }
        
        var height = 66 // top
        if let imagesLayout = imagesLayout {
            height += imagesLayout.height(for: preferredWidth)
        }
        else {
            height += 94 // no functionality
        }
        height += 44 // toolbar
        
        height += 1
        preferredHeight = height
        return height
    }
    
    func height(for width: Int) -> Int {
        if width != preferredWidth {
            preferredWidth = width
        }
        
        return height
    }

    init(itemId: String, ownerName: String, avatar: Avatar, date: Date, imagesLayout: ImagesLayout?, likesCount: Int, isLiked: Bool) {
        self.itemId = itemId
        self.ownerName = ownerName
        self.avatar = avatar
        self.date = date
        self.imagesLayout = imagesLayout
        self.likesCount = likesCount
        self.isLiked = isLiked
    }
}
