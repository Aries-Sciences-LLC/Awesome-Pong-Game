//
//  Scores.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

struct Scores: Codable {
    var opponent: Int
    var player: Int
    
    var won: Bool? {
        get {
            return player != opponent ? player > opponent : nil
        }
    }
    
    var winningScore: Int {
        get {
            if player > opponent {
                return player
            }
            
            return opponent
        }
    }
    
    var losingScore: Int {
        get {
            if player < opponent {
                return player
            }
            
            return opponent
        }
    }
}
