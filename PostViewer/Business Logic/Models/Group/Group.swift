//
//  Group.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// Group model
class Group: Equatable, Hashable {
    
    /// Group id
    let id: Int
    
    /// Group display name
    let name: String
    
    /// Group avatar
    let avatar: Avatar
    
    /// Basic Group initializer
    ///
    /// - Parameters:
    ///   - id: group id
    ///   - name: group display name
    ///   - avatar: group avatar object
    init(id: Int, name: String, avatar: Avatar) {
        
        self.id = id
        self.name = name
        self.avatar = avatar
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return id
    }
}
