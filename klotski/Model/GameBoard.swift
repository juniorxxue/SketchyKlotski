//
//  GameBoard.swift
//  klotski
//
//  Created by Shawn Xu on 5/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation

class GameBoard {
    
    var map = Map()
    
    
    func isBlockEmpty(in block: (x: Int, y:Int)) -> Bool {
        return !map[block.x, block.y]
    }
    
    
    func updateMap(all cards: [Card]) {
        map.restore()
        for card in cards {
            for block in card.location {
                map[block.x, block.y] = true
                
//                print(block.x + block.y*4)
            }
        }
//        print(map.core)
    }
    
    func printMap(debug message: String) {
        print(message)
        for y in 0..<5 {
            for x in 0..<4 {
                print("\(map[x, y])", separator: " ", terminator: "")
            }
            print("\n")
        }
    }
    
}
