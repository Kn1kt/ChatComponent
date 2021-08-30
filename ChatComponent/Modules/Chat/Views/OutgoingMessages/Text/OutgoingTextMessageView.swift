//
//  OutgoingTextMessageView.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import SnapKit

open class OutgoingTextMessageView: BaseTextMessageView {
    
    public struct Constants {
        let textFont: UIFont
        let timeFont: UIFont
        let boundsInset: CGFloat
    }
    
    public private(set) lazy var stateImageView = makeStateImageView()
    
    private var constants: Constants?
    
    convenience init(constants: Constants) {
        self.init(boundsInset: constants.boundsInset)
        self.constants = constants
        setupAppearance()
    }
    
    open override func setupSubviews() {
        super.setupSubviews()
        
        stateImageView.setContentHuggingPriority(.required, for: .horizontal)
        
        let timeAndStatusView = UIView()
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
        
        textLabel.textColor = .white
        textLabel.textAlignment = .right
        textLabel.font = constants?.textFont
        
        timeLabel.textColor = .white
        timeLabel.font = constants?.timeFont
        
        stateImageView.tintColor = .white.withAlphaComponent(0.8)
        
        stackView.alignment = .lastBaseline
    }
    
    open func makeStateImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.preferredSymbolConfiguration = .init(font: constants?.timeFont ?? timeLabel.font)
        imageView.image = UIImage(systemName: "checkmark")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
        
}
