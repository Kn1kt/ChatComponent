//
//  MessagesSectionProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import UIKit

public protocol MessagesSectionProtocol: DiffableSection, HeightProvider where DiffableItem: MessagesItemProtocol {
    func itemHeights(withConstrainedWidth width: CGFloat) -> [CGFloat]
}

// MARK: - MessagesSection

public struct MessagesSection: MessagesSectionProtocol {
        
    public let items: [MessagesItem]
        
    public init(items: [MessagesItem]) {
        self.items = items
    }
    
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        return itemHeights(withConstrainedWidth: width).reduce(0, +)
    }
    
    public func itemHeights(withConstrainedWidth width: CGFloat) -> [CGFloat] {
        return items.map { $0.height(withConstrainedWidth: width) }
    }
    
    
    
}
