//
//  BaseTextMessageView.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit

open class BaseTextMessageView: BaseMessageView {
    
    public private(set) lazy var textLabel = makeTextLabel()
    public private(set) lazy var stackView = makeStackView()
    
    private var boundsInset: CGFloat = .zero
    
    convenience init(boundsInset: CGFloat) {
        self.init()
        self.boundsInset = boundsInset
        setupSubviews()
    }
    
    // MARK: - Setup Subviews
    
    open func setupSubviews() {
        textLabel.setContentHuggingPriority(.required - 2, for: .horizontal)
        textLabel.setContentHuggingPriority(.required - 2, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.required - 2, for: .horizontal)
        textLabel.setContentCompressionResistancePriority(.required - 2, for: .vertical)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(boundsInset)
        }
    }
    
    // MARK: - Making Views
    
    open func makeTextLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }
    
    open func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        
        return stack
    }
    
}
