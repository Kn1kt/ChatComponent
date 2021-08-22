//
//  ReusableCell.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 22.08.2021.
//

import Foundation

public protocol ReusableCell: Reusable {
    
    var cellModel: CellViewModelProtocol! { get set }
    
}
