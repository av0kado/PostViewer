//
//  Data+JSONSerialization.swift
//  Portable
//

import Foundation

extension Data {
    
    func jsonDictionary() -> [String : Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [String : Any]
            return json
        }
        catch {
            return nil
        }
    }
    
    func jsonArray() -> [Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? [Any]
            return json
        }
        catch {
            return nil
        }
    }
}
