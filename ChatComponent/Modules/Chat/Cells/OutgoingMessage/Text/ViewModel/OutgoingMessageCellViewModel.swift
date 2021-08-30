//
//  OutgoingMessageCellViewModel.swift
//  ChatComponent
//
//  Created by Nikitos on 29.08.2021.
//

import Foundation
import UIKit.UIFont
import RxSwift
import RxRelay

public struct OutgoingMessageCellViewModelBindings {
    
}

public protocol OutgoingMessageCellViewModelProtocol: MessageCellViewModelProtocol {
    
    var width: CGFloat { get }
    var height: CGFloat? { get }
    var message: Observable<TextMessageProtocol> { get }
    
    func setup(bindings: OutgoingMessageCellViewModelBindings) -> Disposable
    
}

open class OutgoingMessageCellViewModel: OutgoingMessageCellViewModelProtocol {
    
    typealias Constants = OutgoingMessageCell.Constants
    
    public let cellIdentifier = OutgoingMessageCell.reuseIdentifier
    public let identifier = UUID()
    
    public var message: Observable<TextMessageProtocol> { _message.asObservable() }
    private let _message: BehaviorRelay<TextMessageProtocol>
    
    public private(set) var width: CGFloat = .zero
    public private(set) var height: CGFloat?
    
    public init(message: TextMessageProtocol) {
        _message = .init(value: message)
    }
    
    public func setup(bindings: OutgoingMessageCellViewModelBindings) -> Disposable {
        return Disposables.create()
    }
    
    public func accept(newMessage: Message) {
        guard case let .text(message) = newMessage else { return }
        
        height = nil
        _message.accept(message)
    }
    
    public func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        self.width = width
        if let height = height { return height }
        
        let message = _message.value
        let widhtWithInsets = width - Constants.boundsInset * 2
        let textFont = Constants.textFont
        let timeFont = Constants.timeFont
        let timeHeight = timeFont.lineHeight
        
        let textHeight = message.text.height(withConstrainedWidth: widhtWithInsets, font: Constants.textFont)
        
        // For multi line text
        var cellHeight = textHeight
            + timeHeight
            + Constants.verticalInteritemSpacing
            + Constants.boundsInset * 2
        
        if textHeight <= textFont.lineHeight.rounded(.up) {
            let textWidth = message.text.width(withConstrainedHeight: textFont.lineHeight, font: textFont)
            let timeText = Constants.timeFormatter.string(from: message.time) + "oo" // For symbol image
            let timeWidth = timeText.width(withConstrainedHeight: timeHeight, font: timeFont)
            
            if textWidth + Constants.horizontalInteritemSpacing + timeWidth <= widhtWithInsets {
                // For single line text
                cellHeight = textHeight + Constants.boundsInset * 2
            }
        }
                
        height = cellHeight
        
        return cellHeight
    }
    
}
