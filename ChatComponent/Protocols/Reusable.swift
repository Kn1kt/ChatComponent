//
//  Reusable.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import Foundation

public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String { .init(describing: self) }
}
