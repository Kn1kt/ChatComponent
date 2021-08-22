//
//  MessagesViewModel.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation
import RxSwift
import RxRelay

public protocol MessagesViewModelProtocol: AnyObject {
    
    associatedtype Section: MessagesSectionProtocol
    
    var sections: BehaviorRelay<[Section]> { get }
    
    /// Forward Pagination
    var fetchingNewMessages: BehaviorRelay<Bool> { get }
    
    /// Backward Pagination
    var fetchingOldMessages: BehaviorRelay<Bool> { get }
    
    func setup(bindings: MessagesViewModelBindings) -> Disposable
    
}

public final class MessagesViewModel: MessagesViewModelProtocol {
    
    public typealias Section = MessagesSection
    
    public let sections: BehaviorRelay<[Section]> = .init(value: [])
    
    public let fetchingNewMessages: BehaviorRelay<Bool> = .init(value: false)
    public let fetchingOldMessages: BehaviorRelay<Bool> = .init(value: false)
    
    private let chatID: Int
    
    private let messagesService: MessagesServiceProtocol
    
    private let defaultScheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    private let userInitiatedSerialScheduler = SerialDispatchQueueScheduler(qos: .userInitiated)
    
    public init(chatID: Int, messagesService: MessagesServiceProtocol) {
        self.chatID = chatID
        self.messagesService = messagesService
    }
    
    public func setup(bindings: MessagesViewModelBindings) -> Disposable {
        return Disposables.create()
    }
    
    private func setupSections() -> Disposable {
        return messagesService.getMessagesWithChangeset(for: chatID)
            .subscribe(on: userInitiatedSerialScheduler)
            .withLatestFrom(sections) { ($1, $0) }
            .compactMap { [weak self] in self?.update(sections: $0, with: $1) }
            .bind(to: sections)
    }
    
    private func update(sections: [Section], with updateEvent: ([Message], CollectionChangeset?)) -> [Section] {
        let (newMessages, changeset) = updateEvent
        
//        guard let changeset = changeset else {
//            return newMessages.map { message in
//                switch message {
//                case let .text(message):
//                    return 
//                }
//            }
//        }
        
        return []
    }
}
