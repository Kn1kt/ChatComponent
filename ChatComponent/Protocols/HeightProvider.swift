//
//  HeightProvider.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 23.08.2021.
//

import UIKit

public protocol HeightProvider {
    
    func height(withConstrainedWidth width: CGFloat) -> CGFloat
    
}
