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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Subviews
    
    open func setupSubviews() {
        let lowPriority = UILayoutPriority(rawValue: 230)
        
        textLabel.setContentHuggingPriority(lowPriority, for: .horizontal)
        textLabel.setContentHuggingPriority(lowPriority, for: .vertical)
        textLabel.setContentCompressionResistancePriority(lowPriority, for: .horizontal)
        textLabel.setContentCompressionResistancePriority(lowPriority, for: .vertical)
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    // MARK: - Making Views
    
    open func makeTextLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }
    
    open func makeStackView() -> UIStackView {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }
    
}
