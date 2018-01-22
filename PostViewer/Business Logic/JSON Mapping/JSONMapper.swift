//
//  JSONMapper.swift
//  PostViewer
//
//  Created by Amir Zigangarayev on 19/01/2018.
//  Copyright © 2018 Amir Zigangarayev. All rights reserved.
//

class JSONMapper<T : JSONMappable> {
    
    /// Maps object with given json
    ///
    /// - Parameter json: json to map
    /// - Returns: mapped object
    func map(json: [String : Any]) -> T? {
        return T(json: json)
    }
    
    /// Array of objects mapped with given json array
    func mapArray(jsonArray: [[String : Any]]) -> [T] {
        
        var result = [T]()
        
        for json in jsonArray {
            if let mappedObject = T(json: json) {
                result.append(mappedObject)
            }
        }
        
        return result
    }
}
