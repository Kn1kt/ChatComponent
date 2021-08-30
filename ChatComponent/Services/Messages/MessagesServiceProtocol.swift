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

public typealias MessagesWithChangeset = ([Message], CollectionChangeset?)

public protocol MessagesServiceProtocol {
    
    func getMessagesWithChangeset(for chatID: Int) -> Observable<MessagesWithChangeset>
    func create(message: Message) -> Single<Void>
}

public final class MockMessagesService: MessagesServiceProtocol {
    
    public struct User: UserProtocol {
        public let id: Int
        public let name: String
        public let imagePath: String
    }
    
    public struct TextMessage: TextMessageProtocol {
        public let text: String
        public let time: Date
        public let state: MessageState
        public let sender: UserProtocol
    }
    
    public struct Changeset: CollectionChangeset {
        public let deleted: [Int]
        public let inserted: [Int]
        public let updated: [Int]
    }
    
    public func makeCurrentUser() -> UserProtocol {
        return User(id: 1,
                    name: "Nikita",
                    imagePath: "")
    }
    
    public func makeInterlocutorUser() -> UserProtocol {
        return User(id: 2,
                    name: "Oleg",
                    imagePath: "")
    }
    
    public func getMessagesWithChangeset(for chatID: Int) -> Observable<MessagesWithChangeset> {
        let sender1 = makeCurrentUser()
        let sender2 = makeInterlocutorUser()
        
        let messageStates: [MessageState] = [.sent, .sending, .read, .unsent]
        let outMessages = (0..<10).map { i in
            return TextMessage(text: "Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text ",
                               time: Date(timeIntervalSinceNow: Double(i * 60)),
                               state: messageStates.randomElement()!,
                               sender: sender1)
        }
                
        let inMessages = (0..<10).map { i in
            return TextMessage(text: "Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text Some in text ",
                               time: Date(timeIntervalSinceNow: Double(i * 60)),
                               state: .sent,
                               sender: sender2)
        }
        
        let messages = (inMessages + outMessages)
            .shuffled()
            .map(Message.text)
        
        let delayedMessages = messages.indices.map { i -> Observable<MessagesWithChangeset> in
            let beforeMessages = Array(messages[...i])
            var changeset: CollectionChangeset?
            
            if i > 0 {
                changeset = Changeset(deleted: [], inserted: [i], updated: [])
            }
            
            return Observable.just((beforeMessages, changeset)).delay(.milliseconds(300 * i), scheduler: MainScheduler.asyncInstance)
        }
        
        return Observable.concat(delayedMessages)
    }
    
    public func create(message: Message) -> Single<Void> {
        return .just(())
    }
    
}
