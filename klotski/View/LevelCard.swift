//
//  LevelCard.swift
//  klotskiMenu
//
//  Created by Shawn Xu on 6/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import Foundation
import UIKit
import VerticalCardSwiper

class LevelCard: CardCell {
    
    
    @IBOutlet weak var levelIndex: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    public func setRandomBackgroundColor() {
        
        let randomRed: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func layoutSubviews() {
        
        self.layer.cornerRadius = 12
        super.layoutSubviews()
    }
    
}
