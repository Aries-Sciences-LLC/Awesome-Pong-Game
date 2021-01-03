//
//  Comparable.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

extension Comparable {
    public mutating func clamp(min: Self, max: Self) {
        self = clamped(min: min, max: max)
    }
    
    public func clamped(min: Self, max: Self) -> Self {
        Swift.max(min, Swift.min(max, self))
    }
}
