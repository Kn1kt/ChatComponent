//
//  OutgoingTextMessageView.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import SnapKit

open class OutgoingTextMessageView: BaseTextMessageView {
    
    public private(set) lazy var stateImageView = makeStateImageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        
        let timeAndStatusView = UIView(frame: .zero)
        timeAndStatusView.addSubview(timeLabel)
        timeAndStatusView.addSubview(stateImageView)
                
        timeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stateImageView.snp.makeConstraints { make in
            make.leading.equalTo(timeLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(timeAndStatusView)
    }
    
    open func setupAppearance() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 12
        layer.cornerCurve = .continuous
        
        textLabel.textColor = .label
        textLabel.textAlignment = .right
        
        timeLabel.textColor = .white
        stateImageView.tintColor = timeLabel.textColor.withAlphaComponent(0.8)
        
        stackView.alignment = .lastBaseline
    }
    
    open func makeStateImageView() -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        imageView.preferredSymbolConfiguration = .init(font: timeLabel.font)
        imageView.image = UIImage(systemName: "checkmark")
        
        return imageView
    }
        
}
