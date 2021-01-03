//
//  UIView.swift
//  Pong
//
//  Created by Ozan Mirza on 1/2/21.
//  Copyright © 2021 BurcuMirza. All rights reserved.
//

import UIKit

extension UIView {
    func shadow() -> CALayer {
        let shadow = CALayer()
        shadow.shadowColor = UIColor.label.cgColor
        shadow.shadowOffset = .zero
        shadow.shadowRadius = 20
        shadow.shadowOpacity = 1
        
        return shadow
    }
}
