//
//  IncomingTextMessageView.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit

open class IncomingTextMessageView: BaseTextMessageView {
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        timeLabel.textColor = .secondaryLabel
        
        stackView.alignment = .lastBaseline
    }
    
}
