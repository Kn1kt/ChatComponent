//
//  CellViewModelProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol CellViewModelProtocol {
    
    var cellIdentifier: String { get }
    var identifier: UUID { get }
    
}
