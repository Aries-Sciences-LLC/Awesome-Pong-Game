//
//  UIGeometry.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension UIOffset: CGFloatListRepresentable {
    public init(floatList: [CGFloat]) {
        let floatList = floatList + [0, 0]
        self.init(horizontal: floatList[0], vertical: floatList[1])
    }
    
    public var floatList: [CGFloat] {
        get {
            [horizontal, vertical]
        }
        set {
            horizontal = newValue[0]
            vertical = newValue[1]
        }
    }
}

extension UIEdgeInsets: CGFloatListRepresentable {
    public init(floatList: [CGFloat]) {
        let floatList = floatList + [0, 0, 0, 0]
        self.init(top: floatList[0], left: floatList[1], bottom: floatList[2], right: floatList[3])
    }
    
    public var floatList: [CGFloat] {
        get { [top, left, bottom, right] }
        set {
            top = newValue[0]
            left = newValue[1]
            bottom = newValue[2]
            right = newValue[3]
        }
    }
}
