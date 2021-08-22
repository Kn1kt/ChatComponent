//
//  MessageProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 23.08.2021.
//

import Foundation

public protocol MessageProtocol {
    
    var time: Date { get }
    
    var state: MessageState { get }
    var sender: UserProtocol { get }
    
}
