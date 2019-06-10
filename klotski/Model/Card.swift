//
//  Card.swift
//  klotski
//
//  Created by Shawn Xu on 5/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation

enum Type {
    case minion
    case tower
    case champion
}

class Card {
    
    var location: [(x: Int, y: Int)]
    
    var type : Type
    
    // MARK: - Init
    
    init(minion location: [(Int, Int)]) {
        self.location = location
        type = .minion
    }
    
    init(tower location: [(Int, Int)]) {
        self.location = location
        type = .tower
    }
    
    init(champion location: [(Int, Int)]) {
        self.location = location
        type = .champion
    }
    
    // MARK: - Can Move?
    
    func canMoveDown(in board: GameBoard) -> Bool {
        
        let bottomLocation = getBottomLocation(in: board)
        
        // 1. arrive at board bottom
        if bottomLocation[0].y == board.map.bottom { // 4
            return false
        } else if (bottomLocation[0].y > board.map.bottom) {
            print("What the Heck???")
        }
        
        // 2. other object blocked
        
        let result = bottomLocation.filter{ board.isBlockEmpty(in: ($0.x, $0.y + 1)) }
        
        if result.count == bottomLocation.count {
            return true
        }
        
        return false

    }
    
    func canMoveUp(in board: GameBoard) -> Bool {
        let topLocation = getTopLocation(in: board)
        
        // 1. arrive at board top
        if topLocation[0].y == board.map.top { // 0
            return false
        } else if (topLocation[0].y < board.map.top) {
            print("It can't be!")
        }
        
        // 2. other object block
        
        let result = topLocation.filter { board.isBlockEmpty(in: ($0.x, $0.y - 1))}
        
        if result.count == topLocation.count {
            return true
        }
        
        return false
    }
    
    func canMoveLeft(in board: GameBoard) -> Bool {
        
        let leftLocation = getLeftLocation(in: board)
        
        // 1. arrive at board left
        if leftLocation[0].x == board.map.leftest { //0
            return false
        } else if (leftLocation[0].x < board.map.leftest) {
            print("No Way!!")
        }
        // 2. other object block
        
        let result = leftLocation.filter { board.isBlockEmpty(in: ($0.x - 1, $0.y ))}
        
        if result.count == leftLocation.count {
            return true
        }
        
        return false
        
    }
    
    func canMoveRight(in board: GameBoard) -> Bool {
        
        let rightLocation = getRightLocation(in: board)
        
        // 1. arrive at board right
        
        if rightLocation[0].x == board.map.rightest { // 3
            return false
        } else if (rightLocation[0].x > board.map.rightest) {
            print("Impossible!")
        }
        
        // 2. other object block
        
        let result = rightLocation.filter { board.isBlockEmpty(in: ($0.x + 1, $0.y ))}
        
        if result.count == rightLocation.count {
            return true
        }
        
        return false
    }
    
    // MARK: - Move Action
    
    func moveDown (block number: Int) {
        
        var newLocation: [(Int, Int)] = []
        
        for (x, y) in location {
            newLocation.append((x, y+1))
        }
        
        location = newLocation
        
    }
    
    func moveUp (block number: Int) {
        
        var newLocation: [(Int, Int)] = []
        
        for (x, y) in location {
            newLocation.append((x, y-1))
        }
        
        location = newLocation
        
    }
    
    func moveLeft (block number: Int) {
        var newLocation: [(Int, Int)] = []
        
        for (x, y) in location {
            newLocation.append((x-1, y))
        }
        
        location = newLocation
        
    }
    
    func moveRight (block number: Int) {
        var newLocation: [(Int, Int)] = []
        
        for (x, y) in location {
            newLocation.append((x+1, y))
        }
        
        location = newLocation
    }
    
    // MARK: - Edge Location
    
    func getBottomLocation (in board: GameBoard) -> [(x: Int, y: Int)] {
        
        switch type {
        case .minion:
            return location
        case .tower,
             .champion:
            var bottom: Int = board.map.top
            for (_, y) in location {
                if(y > bottom) {
                    bottom = y
                }
            }
            return location.filter { $0.y == bottom }
            
        }
    }
    
    func getTopLocation (in board: GameBoard) -> [(x: Int, y: Int)] {
        
        switch type {
        case .minion:
            return location
        case .tower,
             .champion:
            var top: Int = board.map.bottom
            for (_, y) in location {
                if (y < top) {
                    top = y
                }
            }
            return location.filter { $0.y == top }
        
        }
        
    }
    
    func getLeftLocation (in board: GameBoard) -> [(x: Int, y: Int)] {
        
        switch type {
        case .minion:
            return location
        case .tower,
             .champion:
            var leftest: Int = board.map.rightest // 3
            for(x, _) in location {
                if (x < leftest) {
                    leftest = x
                }
            }
            return location.filter { $0.x == leftest }
        }
    }
    
    func getRightLocation (in board: GameBoard) -> [(x: Int, y: Int)] {
        
        switch type {
        case .minion:
            return location
        case .tower,
             .champion:
            var rightest: Int = board.map.leftest // 0
            for(x, _) in location {
                if (x > rightest) {
                    rightest = x
                }
            }
            return location.filter { $0.x == rightest }
        }
    }

    
}
