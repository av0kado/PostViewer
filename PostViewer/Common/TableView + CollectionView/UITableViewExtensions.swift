//
//  UITableViewExtensions.swift
//  Portable
//

import Foundation
import UIKit

extension UITableView {
    
    /// Присваиваем таблице пустой футер, чтобы в конце не отрисовывались бесконечные сепараторы
    func assignEmptyTableFooterToHideEmptyCellsSeparators() {
        tableFooterView = UIView()
    }
    
    /// Регистрируем nib ячейки. Имя nib берется из метода cellNibName cell object ячейки.
    ///
    /// - Parameter cellObjectType: тип cell object ячейки
    func registerCellNib(for cellObjectType: CellObject.Type) {
        let nib = UINib(nibName: cellObjectType.cellNibName(), bundle: nil)
        register(nib, forCellReuseIdentifier: cellObjectType.cellReuseIdentifier())
    }
    
    /// Регистрируем nib заголовка. Имя nib берется из метода headerNibName header object заголовка.
    ///
    /// - Parameter headerObjectType: тип header object заголовка
    func registerHeaderNib(for headerObjectType: HeaderObject.Type) {
        let nib = UINib(nibName: headerObjectType.headerNibName(), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: headerObjectType.headerReuseIdentifier())
    }
    
    /// Регистрируем nib футера. Имя nib берется из метода footerNibName footer object футера.
    ///
    /// - Parameter footerObjectType: тип footer object футера
    func registerFooterNib(for footerObjectType: FooterObject.Type) {
        let nib = UINib(nibName: footerObjectType.footerNibName(), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: footerObjectType.footerReuseIdentifier())
    }
}
