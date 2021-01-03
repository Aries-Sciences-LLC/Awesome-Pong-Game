//
//  TranserfableData.swift
//  Pong
//
//  Created by Ozan Mirza on 1/3/21.
//  Copyright © 2021 BurcuMirza. All rights reserved.
//

import UIKit

struct Point: Codable {
    var x: CGFloat
    var y: CGFloat?
    
    var vector: CGVector {
        return CGVector(dx: x, dy: y ?? 0)
    }
}

struct TransferableData: Codable {
    var ball: Point?
    var enemny: Point
}
