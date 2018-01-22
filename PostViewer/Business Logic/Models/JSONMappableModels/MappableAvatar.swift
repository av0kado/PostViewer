//
//  MappableAvatar.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// Mappable extension to Avatar
extension Avatar: JSONMappable {
    
    // MARK: - JSONMappable
    
    init?(json: [String : Any]) {
        guard let photo100 = json["photo_100"] as? String else {
            return nil
        }
        
        self.init(urlString: photo100)
    }
}
