//
//  Level.swift
//  klotskiMenu
//
//  Created by Shawn Xu on 6/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation

internal class Level :Codable{
    var name: String!
    
    
    init(_ name: String) {
        self.name = name
    }
}
