//
//  LevelSetup.swift
//  klotski
//
//  Created by Shawn Xu on 6/10/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation

class LevelSetup {
    
    static var championData = [1,0,2,0,1,1,2,1]
    static var towerData = [0,0,0,1,3,0,3,1,0,2,0,3,3,2,3,3,1,2,2,2]
    static var minionData = [0,4,1,3,2,3,3,4]
    
    static func intsToTuples(_ data: [Int]) -> [(Int, Int)] {
        var result:[(Int, Int)] = []
        if data.count % 2 != 0 {
            print("Wrong Ints Data")
        } else {
            for index in stride(from: 0, to: data.count, by: 2) {
                result.append((data[index], data[index+1]))
            }
        }
        return result
    }
    
    static func tuplesToInts(_ tuples: [(Int, Int)]) -> [Int] {
        var result:[Int] = []
        for (x, y) in tuples {
            result.append(x)
            result.append(y)
        }
        return result
    }
    
    static func intsToCards(champion cData:[Int], tower tData:[Int], minion mData:[Int]) -> [Card] {
        var cards:[Card] = []
        
        let cTuples = intsToTuples(cData)
        let tTuples = intsToTuples(tData)
        let mTuples = intsToTuples(mData)
        
        let championCard = Card(champion: cTuples)
        cards.append(championCard)
        
        print("tData Count : \(tData.count)")
        
        for index in stride(from: 0, to: tTuples.count, by: 2) {
            let towerCard = Card(tower: [tTuples[index], tTuples[index+1]])
            cards.append(towerCard)
        }
        
        for mTuple in mTuples {
            let minionCard = Card(minion: [mTuple])
            cards.append(minionCard)
        }
        
        return cards
    }
    
    static func loadLevel(level num: Int) -> [Card] {
        return []
    }
    
    
    
    
    static func initLevel0() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        let champion = Card(champion: [(1,0), (2,0), (1,1), (2,1)])
        
        champions.append(champion)
        
        towers.append(Card(tower: [(0,0), (0,1)]))
        towers.append(Card(tower: [(3,0), (3,1)]))
        towers.append(Card(tower: [(0,2), (0,3)]))
        towers.append(Card(tower: [(3,2), (3,3)]))
        towers.append(Card(tower: [(1,2), (2,2)]))
        
        minions.append(Card(minion: [(0,4)]))
        minions.append(Card(minion: [(1,3)]))
        minions.append(Card(minion: [(2,3)]))
        minions.append(Card(minion: [(3,4)]))
        
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
    
    static func initLevel1() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        champions.append(Card(champion: [(1,0), (2,0), (1,1), (2,1)]))
        
        towers.append(Card(tower: [(0,2), (0,3)]))
        towers.append(Card(tower: [(3,2), (3,3)]))
        
        minions.append(Card(minion: [(0,0)]))
        minions.append(Card(minion: [(0,1)]))
        minions.append(Card(minion: [(3,0)]))
        minions.append(Card(minion: [(3,1)]))
        minions.append(Card(minion: [(1,2)]))
        minions.append(Card(minion: [(1,3)]))
        minions.append(Card(minion: [(2,2)]))
        minions.append(Card(minion: [(2,3)]))
        minions.append(Card(minion: [(0,4)]))
        minions.append(Card(minion: [(3,4)]))
        
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
    
    static func initLevel2() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        champions.append(Card(champion: [(1,0), (2,0), (1,1), (2,1)]))
        
        towers.append(Card(tower: [(0,1), (0,2)]))
        towers.append(Card(tower: [(0,3), (0,4)]))
        
        minions.append(Card(minion: [(0,0)]))
        minions.append(Card(minion: [(3,0)]))
        minions.append(Card(minion: [(3,1)]))
        minions.append(Card(minion: [(3,2)]))
        minions.append(Card(minion: [(1,2)]))
        minions.append(Card(minion: [(2,2)]))
        minions.append(Card(minion: [(1,3)]))
        minions.append(Card(minion: [(2,3)]))
        
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
    
    static func initLevel3() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        champions.append(Card(champion: [(1,0), (2,0), (1,1), (2,1)]))
        
        towers.append(Card(tower: [(0,0), (0,1)]))
        towers.append(Card(tower: [(3,0), (3,1)]))
        towers.append(Card(tower: [(1,2), (2,2)]))
        towers.append(Card(tower: [(0,3), (1,3)]))
        towers.append(Card(tower: [(2,3), (3,3)]))
        
        minions.append(Card(minion: [(0,2)]))
        minions.append(Card(minion: [(3,2)]))
        minions.append(Card(minion: [(0,4)]))
        minions.append(Card(minion: [(3,4)]))

        
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
    
    static func initLevel4() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        champions.append(Card(champion: [(1,0), (2,0), (1,1), (2,1)]))
        
        towers.append(Card(tower: [(0,1), (0,2)]))
        towers.append(Card(tower: [(3,1), (3,2)]))
        towers.append(Card(tower: [(1,2), (2,2)]))
        towers.append(Card(tower: [(1,3), (2,3)]))
        towers.append(Card(tower: [(1,4), (2,4)]))
        
        minions.append(Card(minion: [(0,0)]))
        minions.append(Card(minion: [(3,0)]))
        minions.append(Card(minion: [(0,3)]))
        minions.append(Card(minion: [(3,3)]))
        
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
    
    static func initLevel5() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        champions.append(Card(champion: [(1,0), (2,0), (1,1), (2,1)]))
        
        towers.append(Card(tower: [(0,2), (0,3)]))
        towers.append(Card(tower: [(3,2), (3,3)]))
        towers.append(Card(tower: [(1,2), (2,2)]))
        towers.append(Card(tower: [(1,3), (2,3)]))
        towers.append(Card(tower: [(2,4), (3,4)]))
        
        minions.append(Card(minion: [(0,1)]))
        minions.append(Card(minion: [(3,1)]))
        minions.append(Card(minion: [(0,4)]))
        minions.append(Card(minion: [(1,4)]))
        
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
    
    static func initLevel6() -> [Card] {
        
        var champions:[Card] = []
        var towers:[Card] = []
        var minions:[Card] = []
        var cards:[Card] = []
        
        champions.append(Card(champion: [(2,0), (3,0), (2,1), (3,1)]))
        
        towers.append(Card(tower: [(0,0), (0,1)]))
        towers.append(Card(tower: [(0,2), (1,2)]))
        towers.append(Card(tower: [(1,3), (2,3)]))
        towers.append(Card(tower: [(1,4), (2,4)]))
        towers.append(Card(tower: [(3,3), (3,4)]))
        
        minions.append(Card(minion: [(1,0)]))
        minions.append(Card(minion: [(0,4)]))
        minions.append(Card(minion: [(2,2)]))
        minions.append(Card(minion: [(3,2)]))
       
        cards += champions
        cards += towers
        cards += minions
        
        return cards
        
    }
}
