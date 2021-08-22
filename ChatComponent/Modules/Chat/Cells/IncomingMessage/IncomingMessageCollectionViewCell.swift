//
//  IncomingMessageCollectionViewCell.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

open class IncomingMessageCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    public private(set) lazy var messageView = makeMessageView()
    
    public var cellModel: CellViewModelProtocol! {
        didSet { setupBindings(on: cellModel) }
    }
    
    private var disposeBag = DisposeBag()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    open func setupSubviews() {
        contentView.addSubview(messageView)
        messageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.trailing.lessThanOrEqualToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(250).priority(.high)
        }
    }
    
    final func setupBindings(on cellModel: CellViewModelProtocol) {
        
    }
    
    private func makeMessageView() -> IncomingTextMessageView {
        let view = IncomingTextMessageView(frame: .zero)
        return view
    }
}

// MARK: - Binders

extension IncomingMessageCollectionViewCell {
    
    private var updateUI: Binder<TextMessageProtocol> {
        return Binder(self) { cell, message in
            cell.messageView.textLabel.text = message.text
            cell.messageView.timeLabel.text = DateFormatter.localizedString(from: message.time,
                                                                            dateStyle: .none,
                                                                            timeStyle: .short)
        }
    }
    
}
