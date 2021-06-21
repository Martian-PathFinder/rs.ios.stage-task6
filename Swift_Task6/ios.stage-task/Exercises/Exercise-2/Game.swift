//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {
    
    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        var firtsPlayer = Player()
        let values = [Value.six, .seven, .eight, .nine, .ten, .jack, .seven, .king, .ace]
  
        var tmp = 8
        for player in players {
            for index in  0 ..< 6 {
                if ((player.hand?[index].isTrump) == true) {
                    let indexCard = values.firstIndex(where: {$0 == player.hand?[index].value})!
                    if  indexCard <= tmp {
                        tmp = indexCard
                        firtsPlayer = player
                    }
                }
            }
        }
        return firtsPlayer
    }
}
