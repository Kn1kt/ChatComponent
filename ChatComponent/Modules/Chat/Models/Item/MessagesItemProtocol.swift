//
//  MessagesItemProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import UIKit

public protocol MessagesItemProtocol: Hashable, HeightProvider {
        
    var cellModel: MessageCellViewModelProtocol { get }
    
}

// MARK: - MessagesItem

public struct MessagesItem: MessagesItemProtocol {
        
    public let cellModel: MessageCellViewModelProtocol
        
    public init(cellModel: MessageCellViewModelProtocol) {
        self.cellModel = cellModel
    }
    
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        return cellModel.height(withConstrainedWidth: width)
    }
    
}

// MARK: - Hashable

extension MessagesItem {
    
    public static func == (lhs: MessagesItem, rhs: MessagesItem) -> Bool {
        return lhs.cellModel.identifier == rhs.cellModel.identifier
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(cellModel.identifier)
    }
    
}
