//
//  Game.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

struct Game: Codable {
    var duration: TimeInterval
    var timestamp: Date
    var scores: Scores
    var mode: GameMode
}
