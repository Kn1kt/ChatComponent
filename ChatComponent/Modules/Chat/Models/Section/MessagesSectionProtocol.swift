//
//  MessagesSectionProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol MessagesSectionProtocol: DiffableSection, HeightProvider where DiffableItem: MessagesItemProtocol {
                
}

// MARK: - MessagesSection

public struct MessagesSection: MessagesSectionProtocol {
        
    public let items: [MessagesItem]
    
    public var height: Int { items.map(\.height).reduce(0, +) }
    
    public init(items: [MessagesItem]) {
        self.items = items
    }
}
