//
//  DictionaryAdditionOperators.swift
//  Portable
//

import Foundation

// Dictionary addition operators

func + <KeyType, ValueType> (left: [KeyType : ValueType], right: [KeyType : ValueType]) -> [KeyType : ValueType] {
    var result = [KeyType : ValueType]()
    result += left
    result += right
    return result
}

func += <KeyType, ValueType> (left: inout [KeyType : ValueType], right: [KeyType : ValueType]) {
    for (key, value) in right {
        left[key] = value
    }
}

func += <KeyType, ValueType> (left: inout [KeyType : ValueType]!, right: [KeyType : ValueType]) {
    for (key, value) in right {
        left[key] = value
    }
}

func += <KeyType, ValueType> (left: inout [KeyType : ValueType], right: [KeyType : ValueType]!) {
    for (key, value) in right {
        left[key] = value
    }
}

func += <KeyType, ValueType> (left: inout [KeyType : ValueType]!, right: [KeyType : ValueType]!) {
    for (key, value) in right {
        left[key] = value
    }
}

// Dictionary substraction operators

func -= <KeyType, ValueType> (left: inout [KeyType : ValueType], right: [KeyType : ValueType]) {
    for (key, _) in right {
        left[key] = nil
    }
}

func -= <KeyType, ValueType> (left: inout [KeyType : ValueType]!, right: [KeyType : ValueType]) {
    for (key, _) in right {
        left[key] = nil
    }
}

func -= <KeyType, ValueType> (left: inout [KeyType : ValueType], right: [KeyType : ValueType]!) {
    for (key, _) in right {
        left[key] = nil
    }
}

func -= <KeyType, ValueType> (left: inout [KeyType : ValueType]!, right: [KeyType : ValueType]!) {
    for (key, _) in right {
        left[key] = nil
    }
}

extension NSDictionary {
    
    /// Dictionary subscript extension that allows to send a set of keys
    ///
    /// - parameter path: variadic parameter, path to object
    ///
    /// - returns: object at path or nil
    public subscript (path: String...) -> Any? {
        
        // this subscript is called even when passing one key (json["key"])
        
        var value: Any? = nil
        
        if path.count == 1 {
            value = self.value(forKey: path.first!)
        }
        else {
            value = valueForKeyPathInArray(path: path)
        }
        
        // we don't need NSNull when we have nil
        return value is NSNull ? nil : value
    }
    
    /// Bypasses tree accordingly to given path
    ///
    /// - parameter path: path in the tree
    ///
    /// - returns: object at path or nil if path doesn't exist
    public func valueForKeyPathInArray(path: [String]) -> Any? {
        
        var value: Any? = self
        var json: NSDictionary = self
        
        for pathComponent in path {
            
            if let valueJson = value as? NSDictionary {
                json = valueJson
            }
            else {
                value = nil
                break
            }
            
            value = json.value(forKey: pathComponent)
        }
        
        return value
    }
}
