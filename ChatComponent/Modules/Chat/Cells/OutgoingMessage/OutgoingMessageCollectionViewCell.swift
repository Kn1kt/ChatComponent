//
//  OutgoingMessageCollectionViewCell.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

open class OutgoingMessageCollectionViewCell: UICollectionViewCell, ReusableCell {
    
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
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(250).priority(.high)
        }
    }
    
    final func setupBindings(on cellModel: CellViewModelProtocol) {
        
    }
    
    private func makeMessageView() -> OutgoingTextMessageView {
        let view = OutgoingTextMessageView(frame: .zero)
        return view
    }
    
}

// MARK: - Binders

extension OutgoingMessageCollectionViewCell {
    
    private var updateUI: Binder<TextMessageProtocol> {
        return Binder(self) { cell, message in
            cell.messageView.textLabel.text = message.text
            cell.messageView.timeLabel.text = DateFormatter.localizedString(from: message.time,
                                                                            dateStyle: .none,
                                                                            timeStyle: .short)
            
            cell.messageView.stateImageView.tintColor = message.state == .unsent
                ? .systemRed
                : cell.messageView.textLabel.textColor.withAlphaComponent(0.8)
            
            switch message.state {
            case .unsent:
                cell.messageView.stateImageView.image = UIImage(systemName: "exclamationmark.circle.fill")
            case .sending:
                cell.messageView.stateImageView.image = UIImage(systemName: "clock.fill")
            case .sent:
                cell.messageView.stateImageView.image = UIImage(systemName: "checkmark.circle")
            case .read:
                cell.messageView.stateImageView.image = UIImage(systemName: "checkmark.circle.fill")
            }
        }
    }
    
}
