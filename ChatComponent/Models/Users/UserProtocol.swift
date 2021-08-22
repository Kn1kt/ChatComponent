//
//  UserProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol UserProtocol {
    
    var id: Int { get }
    var name: String { get }
    var imagePath: String { get }
    
}

public extension UserProtocol {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
