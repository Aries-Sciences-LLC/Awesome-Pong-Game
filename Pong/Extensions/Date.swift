//
//  Date.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: self)
    }
}
