//
//  MappableGroup.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

import Foundation

/// Mappable version of group
class MappableGroup: Group, JSONMappable {
    
    // MARK: - JSONMappable
    
    required init?(json: [String : Any]) {
        
        guard let id = json["id"] as? Int, let name = json["name"] as? String, let avatar = Avatar(json: json) else {
            return nil
        }
        
        super.init(id: id, name: name, avatar: avatar)
    }
}
