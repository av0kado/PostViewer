//
//  User.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

/// User model
class User: Equatable, Hashable {
    
    /// User id
    let id: Int
    
    /// User's first name
    let firstName: String
    
    /// User's last name
    let lastName: String
    
    /// User's avatar object
    let avatar: Avatar
    
    /// Basic initializer
    ///
    /// - Parameters:
    ///   - id: user id
    ///   - firstName: user's first name
    ///   - lastName: user's last name
    ///   - avatar: user's avatar model
    init(id: Int, firstName: String, lastName: String, avatar: Avatar) {
        
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
    
    // MARK: - Equatable
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Hashable
    
    var hashValue: Int {
        return id
    }
}
