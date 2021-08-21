//
//  MessagesViewModelBindings.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation
import RxSwift

public struct MessagesViewModelBindings {
    
    public let sendMessage: Observable<String>
    public let sendImage: Observable<Data>
    
    /// Forward Pagination
    public let fetchNewMessages: Observable<Void>
    
    /// Backward Pagination
    public let fetchOldMessages: Observable<Void>
    
    public init(sendMessage: Observable<String>,
                sendImage: Observable<Data>,
                fetchNewMessages: Observable<Void>,
                fetchOldMessages: Observable<Void>) {
        
        self.sendMessage = sendMessage
        self.sendImage = sendImage
        self.fetchNewMessages = fetchNewMessages
        self.fetchOldMessages = fetchOldMessages
    }
    
}
