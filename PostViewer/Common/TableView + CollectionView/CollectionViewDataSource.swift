//
//  CollectionViewDataSource.swift
//  Portable
//

import Foundation
import UIKit

/// Класс, реализующий все методы, необходимые для конфигурации и работы с collection view
class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    fileprivate(set) var dataStructure: CollectionViewDataSourceStructure
    weak var delegate: UICollectionViewDelegate?
    
    init(with structure: CollectionViewDataSourceStructure) {
        dataStructure = structure
        super.init()
    }
    
    init(with structure: CollectionViewDataSourceStructure, and localDelegate: UICollectionViewDelegate) {
        delegate = localDelegate
        dataStructure = structure
        super.init()
    }
    
    /// Сконфигурировать для работы с переданной collectionView
    func assign(to collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Определяем имплементированы ли опциональные методы
    
    override func responds(to aSelector: Selector!) -> Bool {
        switch aSelector! {
            case #selector(collectionView(_:layout:sizeForItemAt:)):
                return delegate?.responds(to: aSelector) ?? false
            default:
                return super.responds(to: aSelector)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataStructure.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStructure.numberOfObjects(at: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Здесь нет проверки на возврат nil потому как если внезапно для indexPath, который существует для collectionView, вернулся пустой cellObject, это наша явная проблема и надо упасть еще в моменте дебага
        
        let cellObject = dataStructure.cellObject(at: indexPath)!
        
        let reuseIdentifier = type(of: cellObject).cellReuseIdentifier()
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let configurableCell = cell as? ConfigurableView {
            configurableCell.configure(with: cellObject)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var identifier: String? = nil
        var supplementaryViewObject: Any? = nil
        
        if kind == UICollectionElementKindSectionHeader {
            let headerObject = self.dataStructure.headerObject(for: indexPath.section)
            if let unwrapperdHeaderObject = headerObject {
                identifier = type(of: unwrapperdHeaderObject).headerReuseIdentifier()
                supplementaryViewObject = unwrapperdHeaderObject
            }
        }
        else if kind == UICollectionElementKindSectionFooter {
            let footerObject = self.dataStructure.footerObject(for: indexPath.section)
            if let unwrapperdFooterObject = footerObject {
                identifier = type(of: unwrapperdFooterObject).footerReuseIdentifier()
                supplementaryViewObject = unwrapperdFooterObject
            }
        }
        
        //Здесь нет проверки на возврат nil потому как если внезапно для indexPath, который существует для collectionView, вернулся пустой headerObject или footerObject, это наша явная проблема и надо упасть еще в моменте дебага
        
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier!, for: indexPath)
        
        if let configurableSupplementaryView = supplementaryView as? ConfigurableView {
            configurableSupplementaryView.configure(with: supplementaryViewObject!)
        }
        
        return supplementaryView
    }
    
    // MARK: - UICollectionViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (delegate as? UICollectionViewDelegateFlowLayout)?.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath) ?? CGSize.zero
    }
    
    //MARK: Helpers
    
    /// Обновить данные секции
    ///
    /// - Parameter dataStructure: структура с данными
    func updateData(with dataStructure: CollectionViewDataSourceStructure, at sectionIndex: Int) {
        
        self.dataStructure.updateSection(from: dataStructure, at: sectionIndex)
    }
    
    /// Вставить новую секцию
    ///
    /// - Parameters:
    ///   - dataStructure: структура с данными
    ///   - place: место вставки
    func insertNewSection(with dataStructure: CollectionViewDataSourceStructure, to place: InsertingPlace) {
        
        self.dataStructure.insertNewSection(from: dataStructure, to: place)
    }
}
