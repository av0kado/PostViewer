//
//  CellObject.swift
//  Portable
//

import Foundation
import UIKit

/// Протокол объекта конфигурации ячеек таблицы/collection view
protocol CellObject  {
    
    /// Метод получения идентификатора ячейки, используемой для отображения данных объекта
    ///
    /// - Returns: идентификатор ячейки
    static func cellReuseIdentifier() -> String
    
    /// Метод получения имени nib ячейки
    ///
    /// - Returns: имя nib ячейки
    static func cellNibName() -> String
}

/// Протокол объекта конфигурации ячеек таблицы, имеющий идентификатор
protocol CellObjectWithId: CellObject {
    
    var itemId: String { get set }
}

extension CellObject {
    
    /// Базовая реализация cellReuseIdentifier
    ///
    /// - Returns: возвращается строковое представление типа, реализующего протокол
    static func cellReuseIdentifier() -> String {
        return String(describing: self)
    }
    
    /// Базовая реализация cellNibName
    ///
    /// - Returns: возвращается строковое представление типа, реализующего протокол, но, если оно оканчивается на "Object", то этот суффикс обрезается
    static func cellNibName() -> String {
        
        let cellObjectSuffix = "Object"
        var nibName = String(describing: self)
        
        guard nibName.hasSuffix(cellObjectSuffix) else {
            return nibName
        }
        
        guard let rangeOfSuffix = nibName.range(of: cellObjectSuffix, options: .backwards, range: nil, locale: nil) else {
            return nibName
        }
        
        nibName.removeSubrange(rangeOfSuffix)
        return nibName
    }
}
