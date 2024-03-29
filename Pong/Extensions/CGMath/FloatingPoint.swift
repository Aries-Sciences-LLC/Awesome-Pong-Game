//
//  FloatingPoint.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

public func lerp<T: FloatingPoint>(start: T, end: T, progress: T) -> T {
    (1 - progress) * start + progress * end
}

public func inverseLerp<T: FloatingPoint>(start: T, end: T, value: T) -> T {
    (value - start) / (end - start)
}

extension FloatingPoint {
    
    public mutating func clamp(min: Self = 0, max: Self = 1) {
        self = clamped(min: min, max: max)
    }
    
    public func clamped(min: Self = 0, max: Self = 1) -> Self {
        Swift.max(min, Swift.min(max, self))
    }
    
    public func remap(from fromRange: (start: Self, end: Self), to toRange: (start: Self, end: Self)) -> Self {
        let t = inverseLerp(start: fromRange.start, end: fromRange.end, value: self)
        return lerp(start: toRange.start, end: toRange.end, progress: t)
    }
}
