//
//  Rx+DiffableDataSources.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import UIKit
import RxSwift

// MARK: - Models

public protocol DiffableSection: Hashable {
    
    associatedtype DiffableItem: Hashable
    
    var items: [DiffableItem] { get }
    
}

// MARK: - Array

public extension Array where Element: DiffableSection {
    
    func makeSnapshot() -> NSDiffableDataSourceSnapshot<Element, Element.DiffableItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Element, Element.DiffableItem>()
        self.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(section.items)
        }
        
        return snapshot
    }
    
}

// MARK: - Reactive

public extension Reactive {
    
    // MARK: Table View
    
    func applySnapshot<S: DiffableSection>(animatingDifferences: Bool = true) -> Binder<[S]> where Base: UITableViewDiffableDataSource<S, S.DiffableItem> {
        return Binder(self.base, scheduler: MainScheduler.asyncInstance) { dataSource, sections in
            dataSource.apply(sections.makeSnapshot(), animatingDifferences: animatingDifferences)
        }
    }
    
    // MARK: Collection View
    
    func applySnapshot<S: DiffableSection>(animatingDifferences: Bool = true) -> Binder<[S]> where Base: UICollectionViewDiffableDataSource<S, S.DiffableItem> {
        return Binder(self.base, scheduler: MainScheduler.asyncInstance) { dataSource, sections in
            dataSource.apply(sections.makeSnapshot(), animatingDifferences: animatingDifferences)
        }
    }
    
}
