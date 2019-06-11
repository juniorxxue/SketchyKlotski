//
//  LevelSetup.swift
//  klotski
//
//  Created by Shawn Xu on 6/10/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

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
        switch num {
        case 0:
            return intsToCards(champion: Defaults[.userLevel0Champions], tower: Defaults[.userLevel0Towers], minion: Defaults[.userLevel0Minions])
        case 1:
            return intsToCards(champion: Defaults[.userLevel1Champions], tower: Defaults[.userLevel1Towers], minion: Defaults[.userLevel1Minions])
        case 2:
            return intsToCards(champion: Defaults[.userLevel2Champions], tower: Defaults[.userLevel2Towers], minion: Defaults[.userLevel2Minions])
        case 3:
            return intsToCards(champion: Defaults[.userLevel3Champions], tower: Defaults[.userLevel3Towers], minion: Defaults[.userLevel3Minions])
        case 4:
            return intsToCards(champion: Defaults[.userLevel4Champions], tower: Defaults[.userLevel4Towers], minion: Defaults[.userLevel4Minions])
        default:
            return intsToCards(champion: Defaults[.userLevel0Champions], tower: Defaults[.userLevel0Towers], minion: Defaults[.userLevel0Minions])
        }
    }
    

}
