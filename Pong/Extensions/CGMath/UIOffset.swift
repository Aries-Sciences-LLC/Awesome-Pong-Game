//
//  UIOffset.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension UIOffset {
    
    public var asPoint: CGPoint {
        convert()
    }
    
    public var asVector: CGVector {
        convert()
    }
    
}
