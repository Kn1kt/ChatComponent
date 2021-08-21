//
//  MessagesViewModel.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation
import RxSwift
import RxRelay

public protocol MessagesViewModelProtocol {
    
    associatedtype Section: MessagesSectionProtocol
    
    var sections: BehaviorRelay<[Section]> { get }
    
    var isFetchingMessages: PublishRelay<Bool> { get }
    var isNextPageLoading: BehaviorRelay<Bool> { get }
    
    func setup(bindings: MessagesViewModelBindings) -> Disposable
    
}
