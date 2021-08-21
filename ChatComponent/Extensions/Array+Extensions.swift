//
//  Array+Extensions.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import Foundation

public extension Array {
    
    subscript(safe index: Int) -> Array.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
    
}
