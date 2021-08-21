//
//  IncomingMessageCollectionViewCell.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import SnapKit

open class IncomingMessageCollectionViewCell: UICollectionViewCell, Reusable {
    
    public private(set) lazy var messageView = makeMessageView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupSubviews() {
        messageView.textLabel.text = "Out text"
        messageView.timeLabel.text = "9:41"
        
        contentView.addSubview(messageView)
        messageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.trailing.lessThanOrEqualToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(250).priority(.high)
        }
    }
    
    private func makeMessageView() -> IncomingTextMessageView {
        let view = IncomingTextMessageView(frame: .zero)
        return view
    }
}
