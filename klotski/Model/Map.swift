//
//  Map.swift
//  klotski
//
//  Created by Shawn Xu on 5/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation

// to detect collision

class Map {
    
    var core: [Bool] = []
    
    let top = 0
    let bottom = 4
    let leftest = 0
    let rightest = 3
    
    init() {
        for _ in 0..<20 {
            core.append(false)
        }
    }
    
    subscript(x: Int, y: Int) -> Bool {
        get {
            return core[x + y*4]
        }
        set(newValue) {
            core[x + y*4] = newValue
        }
        
    }
    
    func restore() {
        for i in 0..<20 {
            core[i] = false
        }
    }
}

