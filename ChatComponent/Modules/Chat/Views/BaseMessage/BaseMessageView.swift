//
//  BaseMessageView.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit

open class BaseMessageView: UIView {

    public private(set) lazy var timeLabel = makeTimeLabel()

    open func makeTimeLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        
        return label
    }
    
}
