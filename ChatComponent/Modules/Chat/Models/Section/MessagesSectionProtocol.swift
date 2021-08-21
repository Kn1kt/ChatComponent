//
//  MessagesSectionProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol MessagesSectionProtocol: DiffableSection where DiffableItem: MessagesItemProtocol {
            
    var height: Int { get }
    
}
