//
//  Avatar.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// Model for user's or group's avatar
struct Avatar {
    
    /// Url for small avatar;
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
}
