//
//  CGVector.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension CGVector {
    
    public init(direction: CGVector, magnitude: CGFloat) {
        var direction = direction
        direction.normalize()
        self.init(dx: direction.dx * magnitude, dy: direction.dy * magnitude)
    }
    
    public var asSize: CGSize {
        convert()
    }
    
    public var asPoint: CGPoint {
        convert()
    }
    
    public var asOffset: UIOffset {
        convert()
    }
    
}
