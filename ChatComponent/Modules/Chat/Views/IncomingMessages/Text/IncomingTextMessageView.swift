//
//  IncomingTextMessageView.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit

open class IncomingTextMessageView: BaseTextMessageView {
    
    public struct Constants {
        let textFont: UIFont
        let timeFont: UIFont
        let boundsInset: CGFloat
    }
    
    private var constants: Constants?
    
    convenience init(constants: Constants) {
        self.init(boundsInset: constants.boundsInset)
        self.constants = constants
        setupAppearance()
    }
        
    open override func setupSubviews() {
        super.setupSubviews()
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(timeLabel)
    }
    
    open func setupAppearance() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        layer.cornerCurve = .continuous
        
        textLabel.textColor = .label
        textLabel.textAlignment = .left
        textLabel.font = constants?.textFont
        
        timeLabel.textColor = .secondaryLabel
        timeLabel.font = constants?.timeFont
        
        stackView.alignment = .lastBaseline
    }
    
}
