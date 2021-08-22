//
//  MessagesServiceProtocol.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation
import RxSwift

public enum Message {
    case text(TextMessageProtocol)
}

public protocol MessagesServiceProtocol {
    
    typealias MessagesWithChangeset = ([Message], CollectionChangeset?)
    
    func getMessagesWithChangeset(for chatID: Int) -> Observable<MessagesWithChangeset>
    func create(message: Message) -> Single<Void>
}
