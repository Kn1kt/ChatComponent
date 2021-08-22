//
//  CollectionChangeset.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol CollectionChangeset {
    /// the indexes in the collection that were deleted
    var deleted: [Int] { get }
    
    /// the indexes in the collection that were inserted
    var inserted: [Int] { get }
    
    /// the indexes in the collection that were modified
    var updated: [Int] { get }
}
