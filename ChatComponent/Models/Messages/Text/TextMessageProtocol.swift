//
//  TextMessageProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol TextMessageProtocol: MessageProtocol {
        
    var text: String { get }
    
}
