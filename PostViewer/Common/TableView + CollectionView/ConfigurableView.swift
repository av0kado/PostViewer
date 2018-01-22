//
//  ConfigurableView.swift
//  Portable
//

import Foundation

/// Протокол конфигурации объектов, использующийся для ячеек/хэдеров/футеров таблицы/collection view
protocol ConfigurableView {
    
    /// Метод для конфигурации вьюшки с помощью некоторого объекта, конкретный тип которого известен только самой вьюшке
    ///
    /// - Parameter object: объект конфигурации
    func configure(with object: Any)
}
