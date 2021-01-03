//
//  UIEdgeInsets.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    public var horizontal: CGFloat {
        left + right
    }
    
    public var vertical: CGFloat {
        top + bottom
    }
    
}
