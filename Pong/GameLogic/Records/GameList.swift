//
//  GameList.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

class GameList {
    private(set) var data: [String: [Game]]
    
    public var raw: [Any] {
        get {
            var buffer: [Any] = []
            
            data.forEach({
                buffer.append($0.key)
            })
            
            return (buffer + gamesOnly).adding(0, afterEvery: 3)
        }
    }
    
    public var gamesOnly: [Game] {
        get {
            var buffer: [Game] = []
            
            data.forEach({
                $1.forEach {
                    buffer.append($0)
                }
            })
            
            return buffer
        }
    }
    
    public init() {
        data = [:]
    }
    
    public convenience init(load games: [Game]) {
        self.init()
        games.forEach { (game) in
            self.append(new: game)
        }
    }
    
    public func append(new game: Game) {
        let formatted = game.timestamp.format()
        
        guard data[formatted] != nil else {
            data[formatted] = [game]
            return
        }
        
        data[formatted]?.append(game)
    }
    
//    public func order() {
//        var timestamps: [Date] = []
//        var dates: [String] = []
//        var games: [[Game]] = []
//
//        for (key, value) in data {
//            timestamps.append(value.first!.timestamp)
//            dates.append(key)
//            games.append(value)
//        }
//    }
}
