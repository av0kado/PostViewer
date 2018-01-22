//
//  TableViewDataSource.swift
//  Portable
//

import Foundation
import UIKit

/// Класс, реализующий все методы, необходимые для конфигурации и работы с таблицей
class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate(set) var dataStructure: TableViewDataSourceStructure
    weak var delegate: UITableViewDelegate!
    
    /// Массив заголовков для построения индекса таблицы
    fileprivate(set) var indexTitles: [String]?
    
    /// Маппинг заголовков индексации в номера секций, которые нужно отобразить при выборе данного заголовка
    fileprivate(set) var indexSectionsMap: [String : Int]?
    
    init(with structure : TableViewDataSourceStructure) {
        dataStructure = structure
        super.init()
    }
    
    init(with structure: TableViewDataSourceStructure, and localDelegate: UITableViewDelegate) {
        delegate = localDelegate
        dataStructure = structure
        super.init()
    }
    
    /// Настроить для работы с переданной таблицей
    func assign(to tableView: UITableView) {
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    /// Добавить индексатор для таблицы
    ///
    /// - Parameters:
    ///   - titles: заголовки индексации
    ///   - sectionsMap: маппинг заголовков индексации в номера секций
    func setSectionsIndex(with titles: [String], and sectionsMap: [String : Int]) {
        indexTitles = titles
        indexSectionsMap = sectionsMap
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataStructure.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStructure.numberOfObjects(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Здесь нет проверки на возврат nil потому как если внезапно для indexPath, который существует для таблицы, вернулся пустой cellObject, это наша явная проблема и надо упасть еще в моменте дебага
        
        let cellObject = dataStructure.cellObject(at: indexPath)!
        
        let reuseIdentifier = type(of: cellObject).cellReuseIdentifier()
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        if let configurableCell = cell as? ConfigurableView {
            configurableCell.configure(with: cellObject)
        }
        
        return cell!
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return indexSectionsMap?[title] ?? 0
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = delegate?.tableView?(tableView, heightForRowAt: indexPath) {
            return height
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerObject = dataStructure.headerObject(for: section)
        
        if let unwrapperdHeaderObject = headerObject {
            
            let identifier = type(of: unwrapperdHeaderObject).headerReuseIdentifier()
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
            
            if let configurableHeader = header as? ConfigurableView {
                configurableHeader.configure(with: unwrapperdHeaderObject)
            }
            
            return header
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerObject = dataStructure.footerObject(for: section)
        
        if let unwrapperdFooterObject = footerObject {
            
            let identifier = type(of: unwrapperdFooterObject).footerReuseIdentifier()
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
            
            if let configurableFooter = footer as? ConfigurableView {
                configurableFooter.configure(with: unwrapperdFooterObject)
            }
            
            return footer
        }
        
        return nil
    }
    
    //Методы написаны для того, чтобы в случае, когда хэдер или футер отстутсвуют, не создавались системные отступы
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        if dataStructure.headerObject(for: section) != nil {
            return tableView.estimatedSectionHeaderHeight
        }
        
        return  0
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        if dataStructure.footerObject(for: section) != nil {
            return tableView.estimatedSectionFooterHeight
        }
        
        return  0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard delegate != nil else {
            return indexPath
        }
        
        if delegate!.responds(to: #selector(UITableViewDelegate.tableView(_:willSelectRowAt:))) {
            return delegate?.tableView?(tableView, willSelectRowAt: indexPath)
        }

        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        
        guard delegate != nil else {
            return indexPath
        }
        
        if delegate!.responds(to: #selector(UITableViewDelegate.tableView(_:willDeselectRowAt:))) {
            return delegate?.tableView?(tableView, willDeselectRowAt: indexPath)
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let style = delegate?.tableView?(tableView, editingStyleForRowAt: indexPath)
        return style ?? .none
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return delegate?.tableView?(tableView, editActionsForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        let val =  delegate?.tableView?(tableView, shouldShowMenuForRowAt: indexPath)
        return val ?? false
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        let val = delegate?.tableView?(tableView, canPerformAction: action, forRowAt: indexPath, withSender: sender)
        return val ?? false
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        delegate?.tableView?(tableView, performAction: action, forRowAt: indexPath, withSender: sender)
    }
    
    // MARK: - ScrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
}
