//
//  ReusableCell.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import UIKit

public protocol ReusableCell: UICollectionViewCell, Reusable {
    var cellModel: CellViewModelProtocol! { get set }    
}
