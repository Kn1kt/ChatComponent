//
//  OutgoingMessageCell.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

open class OutgoingMessageCell: UICollectionViewCell, ReusableCell {
    
    public struct Constants {
        static let boundsInset: CGFloat = 8
        static let verticalInteritemSpacing: CGFloat = 0
        static let horizontalInteritemSpacing: CGFloat = 8
        
        static let timeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            return formatter
        }()
        
        static var textFont: UIFont { UIFont.preferredFont(forTextStyle: .subheadline) }
        static var timeFont: UIFont { UIFont.preferredFont(forTextStyle: .caption1) }
    }
    
    public private(set) lazy var messageView = makeMessageView()
    
    public var cellModel: CellViewModelProtocol! {
        didSet { setupBindings(on: cellModel) }
    }
    
    private var widthContsraint: Constraint?
    
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
//            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            
            widthContsraint = make.width.lessThanOrEqualTo(0).priority(999).constraint
        }
    }
    
    final func setupBindings(on cellModel: CellViewModelProtocol) {
        let cellModel = cellModel as! OutgoingMessageCellViewModelProtocol
        let bindings = OutgoingMessageCellViewModelBindings()
        
        disposeBag.insert(
            cellModel.message
                .map { (cellModel, $0) }
                .bind(to: updateUI),
            
            cellModel.setup(bindings: bindings)
        )
    }
    
    private func makeMessageView() -> OutgoingTextMessageView {
        let view = OutgoingTextMessageView(constants: .init(textFont: Constants.textFont,
                                                            timeFont: Constants.timeFont,
                                                            boundsInset: Constants.boundsInset))
        return view
    }
    
}

// MARK: - Binders

extension OutgoingMessageCell {
    
    private var updateUI: Binder<(OutgoingMessageCellViewModelProtocol, TextMessageProtocol)> {
        return Binder(self) { cell, input in
            let (cellModel, message) = input
            let isMultiLineText = (cellModel.height ?? .greatestFiniteMagnitude) > cell.messageView.textLabel.font.lineHeight.rounded(.up) + Constants.boundsInset * 2
            
            cell.widthContsraint?.update(offset: cellModel.width)
            
            cell.messageView.stackView.axis = isMultiLineText ? .vertical : .horizontal
            cell.messageView.stackView.alignment = isMultiLineText ? .fill : .lastBaseline
            cell.messageView.stackView.spacing = isMultiLineText ? Constants.verticalInteritemSpacing : Constants.horizontalInteritemSpacing
            
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
