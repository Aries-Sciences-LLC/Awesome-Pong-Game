//
//  CGSize.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import CoreGraphics

extension CGSize {
    public var aspectRatio: CGFloat {
        width / height
    }
    
    public init(aspectRatio: CGFloat, maxSize size: CGSize) {
        let sizeRatio = size.aspectRatio
        if aspectRatio > sizeRatio {
            self.init(width: size.width, height: size.width / aspectRatio)
        } else {
            self.init(width: size.height * aspectRatio, height: size.height)
        }
    }
    
    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    public var asPoint: CGPoint {
        convert()
    }
    
    public var asVector: CGVector {
        convert()
    }
}
