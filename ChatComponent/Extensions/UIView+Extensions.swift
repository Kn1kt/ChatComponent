//
//  UIView+Extensions.swift
//  ChatComponent
//
//  Created by Nikita Konashenko on 21.08.2021.
//

import UIKit

public extension UIView {
    
    func forAutoLayouts() -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
}
