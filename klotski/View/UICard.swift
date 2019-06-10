//
//  UICard.swift
//  klotski
//
//  Created by Shawn Xu on 5/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//


import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class UICard: UILabel {
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
//    var card: Card
//    var board: GameBoard
    
    
    
    init(with card: Card, in board: GameBoard, scale size: CGFloat) {
        
//        self.card = card
//        self.board = board
        
        let cardFrame: CGRect
        
        let x: CGFloat = CGFloat(card.getLeftLocation(in: board)[0].x) * size
        let y: CGFloat = CGFloat(card.getTopLocation(in: board)[0].y) * size
        let width = CGFloat(
            card.getRightLocation(in: board)[0].x - card.getLeftLocation(in: board)[0].x + 1) * size
        let height = CGFloat(
            card.getBottomLocation(in: board)[0].y - card.getTopLocation(in: board)[0].y + 1) * size
        
        
        cardFrame = CGRect(x: x, y: y, width: width - 6, height: height - 6)
        
        super.init(frame: cardFrame)
        
        switch card.type {
        case .champion:
            self.backgroundColor = UIColor(patternImage: UIImage(named: "white_bk")!)
        case .tower:
            self.backgroundColor = UIColor(patternImage: UIImage(named: "white_bk")!)
        case .minion:
            self.backgroundColor = UIColor(patternImage: UIImage(named: "white_bk")!)
        }
        self.isUserInteractionEnabled = true
        
        // self.addSwipe()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func redraw (with card: Card, in board: GameBoard, scale size: CGFloat) {
        
        let cardFrame: CGRect
        
        let x: CGFloat = CGFloat(card.getLeftLocation(in: board)[0].x) * size
        let y: CGFloat = CGFloat(card.getTopLocation(in: board)[0].y) * size
        let width = CGFloat(
            card.getRightLocation(in: board)[0].x - card.getLeftLocation(in: board)[0].x + 1) * size
        let height = CGFloat(
            card.getBottomLocation(in: board)[0].y - card.getTopLocation(in: board)[0].y + 1) * size
        
        
        cardFrame = CGRect(x: x, y: y, width: width - 6, height: height - 6)
        
        self.frame = cardFrame
        
        
    }
    

    

    
}
