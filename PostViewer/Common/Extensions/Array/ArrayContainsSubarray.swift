//
//  ArrayContainsSubarray.swift
//  Portable
//

extension Array where Element: Equatable {
    
    /// Returns a Boolean value indicating whether the array contains an
    /// all objects of a given array.
    func contains(_ array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
}
