//
//  MessageCellViewModelProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 23.08.2021.
//

import Foundation
import RxRelay

public protocol MessageCellViewModelProtocol: CellViewModelProtocol, HeightProvider {
    
    var message: BehaviorRelay<Message> { get }
    
}
