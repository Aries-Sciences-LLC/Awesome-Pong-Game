//
//  TimeInterval.swift
//  Pong
//
//  Created by Ozan Mirza on 1/2/21.
//  Copyright © 2021 BurcuMirza. All rights reserved.
//

import Foundation

extension TimeInterval {
    var string: String {
        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        var formattedVersion = ""
        if hours == 0 {
            if minutes < 10 {
                formattedVersion = "%2d:%0.2d"
            } else {
                formattedVersion = "%0.2d:%0.2d"
            }
            return String(format: formattedVersion, minutes, seconds)
        } else {
            formattedVersion = "%2d:%0.2d:%0.2d"
            return String(format: formattedVersion, hours, minutes, seconds)
        }
    }
}
