//
//  CGPoint.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension CGPoint {
    
    public init(direction: CGVector, magnitude: CGFloat) {
        let normalized = direction.normalized
        self.init(x: normalized.dx * magnitude, y: normalized.dy * magnitude)
    }
    
    public var asSize: CGSize {
        convert()
    }
    
    public var asVector: CGVector {
        convert()
    }
    
    public var asOffset: UIOffset {
        convert()
    }
    
}
