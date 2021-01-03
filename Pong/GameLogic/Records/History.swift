//
//  History.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import Foundation

class History {
    static let shared = History()
    
    private var keys: Keys
    private(set) var singlePlayerData: GameList
    private(set) var multiplayerData: GameList
    
    public var raw: [Any] {
        get {
            return singlePlayerData.raw + multiplayerData.raw
        }
    }
    
    public init() {
        singlePlayerData = GameList()
        multiplayerData = GameList()
        keys = Keys()
        
        refresh()
    }
    
    public func add(game: Game?, for section: Section) {
        guard let game = game else {
            return
        }
        
        switch section {
        case .single:
            singlePlayerData.append(new: game)
        case .multi:
            multiplayerData.append(new: game)
        }
    }
    
    public func save() {
        var buffer = 0
        do {
            (try [singlePlayerData, multiplayerData].map({ (data) -> Data in
                return try JSONEncoder().encode(data.gamesOnly)
            })).forEach { (encodedData) in
                UserDefaults.standard.set(encodedData, forKey: keys.iterable[buffer])
                buffer += 1
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func refresh() {
        if let data = UserDefaults.standard.data(forKey: keys.singlePlayer) {
            singlePlayerData = GameList(load: load(data: data))
        }
        
        if let data = UserDefaults.standard.data(forKey: keys.multiplayer) {
            multiplayerData = GameList(load: load(data: data))
        }
    }
    
    private func load(data: Data) -> [Game] {
        do {
            return try JSONDecoder().decode([Game].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

class Keys {
    let singlePlayer = "SINGLEPLAYERDATA"
    let multiplayer = "MULTIPLAYERDATA"
    
    var iterable: [String] {
        get {
            return [singlePlayer, multiplayer]
        }
    }
}

enum Section {
    case single, multi
}
