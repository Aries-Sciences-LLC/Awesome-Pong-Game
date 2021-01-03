//
//  UInt16.swift
//  Pong
//
//  Created by Ozan Mirza on 1/3/21.
//  Copyright © 2021 BurcuMirza. All rights reserved.
//

import Foundation

extension Numeric {
    init<D: DataProtocol>(_ data: D) {
        var value: Self = .zero
        let size = withUnsafeMutableBytes(of: &value, { data.copyBytes(to: $0)} )
        assert(size == MemoryLayout.size(ofValue: value))
        self = value
    }
}
