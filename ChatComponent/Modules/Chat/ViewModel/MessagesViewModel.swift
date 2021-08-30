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
    private let user: UserProtocol
    private let messagesService: MessagesServiceProtocol
    
    private let defaultScheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    private let userInitiatedSerialScheduler = SerialDispatchQueueScheduler(qos: .userInitiated)
    
    public init(chatID: Int, user: UserProtocol, messagesService: MessagesServiceProtocol) {
        self.chatID = chatID
        self.user = user
        self.messagesService = messagesService
    }
    
    public func setup(bindings: MessagesViewModelBindings) -> Disposable {
        return Disposables.create([
            setupSections()
        ])
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
        
        guard let changeset = changeset else {
            return makeSections(from: newMessages)
        }
        
        var oldMessages = sections.flatMap(\.items).map(\.cellModel)
        
        changeset.deleted.reversed().forEach { oldMessages.remove(at: $0) }
        changeset.inserted.forEach {
            let newModel = makeViewModel(for: newMessages[$0])
            oldMessages.insert(newModel, at: $0)
        }
        changeset.updated.forEach { oldMessages[$0].accept(newMessage: newMessages[$0]) }
        
        return [Section(items: oldMessages.map(MessagesItem.init))]
    }
    
    private func makeSections(from messages: [Message]) -> [Section] {
        let items = messages.map(makeViewModel(for:))
        return [Section(items: items.map(MessagesItem.init))]
    }
    
    private func makeViewModel(for message: Message) -> MessageCellViewModelProtocol {
        switch message {
        case let .text(textMessage):
            if textMessage.sender.id == user.id {
                return OutgoingMessageCellViewModel(message: textMessage)
            } else {
                return IncomingTextMessageCellViewModel(message: textMessage)
            }
        }
    }
}
