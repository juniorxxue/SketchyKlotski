//
//  ViewController.swift
//  klotski
//
//  Created by Shawn Xu on 5/2/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import UIKit
import RoughSwift
import SwiftyUserDefaults


class GameVC: UIViewController {
    

    
    @IBOutlet weak var gameView: UIView!
    
    
    var levelChosen = 0

    var blockSize: CGFloat!
    
    var board = GameBoard()

    var cards:[Card] = []
    
    let fillStyles:[FillStyle] = [.crossHatch, .dashed, .dots, .hachure, .solid, .starBurst, .sunBurst, .zigzag, .zigzagLine]
    
    
    
    var beginPostion:CGPoint = CGPoint(x: 1, y: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.random()
        let boardWidth = gameView.frame.size.width
        blockSize = boardWidth / 4
        

//        cards = LevelSetup.initLevel4()
        cards = LevelSetup.loadLevel(level: levelChosen)
        
        board.updateMap(all: cards)
        
        
        
        for (index, card) in cards.enumerated() {
            
            let cardView = UICard(with: card, in: board, scale: blockSize)
            
            // Rough Swift Part, CGLayer -> CGView
            let size = CGSize(width: 300, height: 200)
            let layer = draw(size: size, using: { generator in
                var options = Options()
                options.stroke = UIColor.random()
                options.fill = UIColor.random()
                if let fillStyle = fillStyles.randomItem() {
                     options.fillStyle = fillStyle
                }
                generator.rectangle(x: 0, y: 0, width: Float(cardView.frame.width), height: Float(cardView.frame.height), options: options)
            })
            cardView.layer.addSublayer(layer)
            
//            cardView.text = String(index)
//            cardView.textAlignment = .center
            cardView.tag = index
            // cardViews.append(cardView)
            
            let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
            for direction in directions {
                let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
                gesture.direction = direction
                cardView.addGestureRecognizer(gesture)
            }

            gameView.addSubview(cardView)
            
        }
        
    }
    
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        // print(sender.direction)
        // print(sender.location(in: self.view))
//        var cardView = sender.view as! UICard
//        print(cardView.card.location)
        // print(sender.view?.tag)
        
        switch sender.direction {
        case .down:
            
            let CardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
//            print(card.location)
            
//            board.printMap(debug: "--- So, what cannot move down? ---")
            
            if card.canMoveDown(in: board) {
//                print("Yeah~")
                card.moveDown(block: 1)
                board.updateMap(all: cards)
//                board.printMap(debug: "Now the Map is......")
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                CardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
                
                if (card.amIWin(in: board)) {
                    print("WINNNNNNNNNNNN!!!!!!")
                    showToast(message: "Great!")
                    Defaults[.levelPass][levelChosen] = true
                }
            }
            
        case .up:
            let cardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
            if card.canMoveUp(in: board) {
                card.moveUp(block: 1)
                board.updateMap(all: cards)
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                cardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
            
        case .left:
            
            let cardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
            if card.canMoveLeft(in: board) {
                card.moveLeft(block: 1)
                board.updateMap(all: cards)
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                cardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
        case .right:
            
            let cardView = sender.view as! UICard
            let card = cards[sender.view!.tag]
            
            if card.canMoveRight(in: board) {
                card.moveRight(block: 1)
                board.updateMap(all: cards)
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.5)
                cardView.redraw(with: card, in: board, scale: blockSize)
                UIView.commitAnimations()
            }
            
            
        default:
            print("What the Heck")
        }
        
    }
    
    @IBAction func resetTapped(_ sender: Any) {
        switch levelChosen {
        case 0:
            Defaults[.userLevel0Champions] = Defaults[.defaultLevel0Champions]
            Defaults[.userLevel0Towers] = Defaults[.defaultLevel0Towers]
            Defaults[.userLevel0Minions] = Defaults[.defaultLevel0Minions]
        case 1:
            Defaults[.userLevel1Champions] = Defaults[.defaultLevel1Champions]
            Defaults[.userLevel1Towers] = Defaults[.defaultLevel1Towers]
            Defaults[.userLevel1Minions] = Defaults[.defaultLevel1Minions]
        case 2:
            Defaults[.userLevel2Champions] = Defaults[.defaultLevel2Champions]
            Defaults[.userLevel2Towers] = Defaults[.defaultLevel2Towers]
            Defaults[.userLevel2Minions] = Defaults[.defaultLevel2Minions]
        case 3:
            Defaults[.userLevel3Champions] = Defaults[.defaultLevel3Champions]
            Defaults[.userLevel3Towers] = Defaults[.defaultLevel3Towers]
            Defaults[.userLevel3Minions] = Defaults[.defaultLevel3Minions]
        case 4:
            Defaults[.userLevel4Champions] = Defaults[.defaultLevel4Champions]
            Defaults[.userLevel4Towers] = Defaults[.defaultLevel4Towers]
            Defaults[.userLevel4Minions] = Defaults[.defaultLevel4Minions]
        case 5:
            Defaults[.userLevel5Champions] = Defaults[.defaultLevel5Champions]
            Defaults[.userLevel5Towers] = Defaults[.defaultLevel5Towers]
            Defaults[.userLevel5Minions] = Defaults[.defaultLevel5Minions]
        case 6:
            Defaults[.userLevel6Champions] = Defaults[.defaultLevel6Champions]
            Defaults[.userLevel6Towers] = Defaults[.defaultLevel6Towers]
            Defaults[.userLevel6Minions] = Defaults[.defaultLevel6Minions]
        case 7:
            Defaults[.userLevel7Champions] = Defaults[.defaultLevel7Champions]
            Defaults[.userLevel7Towers] = Defaults[.defaultLevel7Towers]
            Defaults[.userLevel7Minions] = Defaults[.defaultLevel7Minions]
        case 8:
            Defaults[.userLevel8Champions] = Defaults[.defaultLevel8Champions]
            Defaults[.userLevel8Towers] = Defaults[.defaultLevel8Towers]
            Defaults[.userLevel8Minions] = Defaults[.defaultLevel8Minions]
        case 9:
            Defaults[.userLevel9Champions] = Defaults[.defaultLevel9Champions]
            Defaults[.userLevel9Towers] = Defaults[.defaultLevel9Towers]
            Defaults[.userLevel9Minions] = Defaults[.defaultLevel9Minions]
        default:
            Defaults[.userLevel0Champions] = Defaults[.defaultLevel0Champions]
            Defaults[.userLevel0Towers] = Defaults[.defaultLevel0Towers]
            Defaults[.userLevel0Minions] = Defaults[.defaultLevel0Minions]
        }
//        self.viewDidLoad()
//        cards = LevelSetup.loadLevel(level: levelChosen)
//        for card in cards {
//            board.updateMap(all: cards)
//
//            UIView.beginAnimations(nil, context: nil)
//            UIView.setAnimationDuration(0.5)
//            cardView.redraw(with: card, in: board, scale: blockSize)
//            UIView.commitAnimations()
//        }
        Defaults[.levelPass][levelChosen] = false
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
        print("It seems you are leaving")
        
        var savedDataChampions: [Int] = []
        var savedDataTowers: [Int] = []
        var savedDataMinions: [Int] = []
        
        for card in cards {
            switch card.type {
            case .champion:
                savedDataChampions += LevelSetup.tuplesToInts(card.location)
            case .tower:
                savedDataTowers += LevelSetup.tuplesToInts(card.location)
            case .minion:
                savedDataMinions += LevelSetup.tuplesToInts(card.location)
            }
        }
        
        print(savedDataChampions)
        print(savedDataTowers)
        print(savedDataMinions)
//        print("---TADA---Real Data-----")
//        print(cards)
//        print("---TADA---Check Default Level 0 Data-----")
//        print(LevelSetup.intsToCards(champion: Defaults[.defaultLevel0Champions], tower: Defaults[.defaultLevel0Towers], minion: Defaults[.defaultLevel0Minions]))
        
        switch levelChosen {
        case 0:
            Defaults[.userLevel0Champions] = savedDataChampions
            Defaults[.userLevel0Towers] = savedDataTowers
            Defaults[.userLevel0Minions] = savedDataMinions
        case 1:
            Defaults[.userLevel1Champions] = savedDataChampions
            Defaults[.userLevel1Towers] = savedDataTowers
            Defaults[.userLevel1Minions] = savedDataMinions
        case 2:
            Defaults[.userLevel2Champions] = savedDataChampions
            Defaults[.userLevel2Towers] = savedDataTowers
            Defaults[.userLevel2Minions] = savedDataMinions
        case 3:
            Defaults[.userLevel3Champions] = savedDataChampions
            Defaults[.userLevel3Towers] = savedDataTowers
            Defaults[.userLevel3Minions] = savedDataMinions
        case 4:
            Defaults[.userLevel4Champions] = savedDataChampions
            Defaults[.userLevel4Towers] = savedDataTowers
            Defaults[.userLevel4Minions] = savedDataMinions
        case 5:
            Defaults[.userLevel5Champions] = savedDataChampions
            Defaults[.userLevel5Towers] = savedDataTowers
            Defaults[.userLevel5Minions] = savedDataMinions
        case 6:
            Defaults[.userLevel6Champions] = savedDataChampions
            Defaults[.userLevel6Towers] = savedDataTowers
            Defaults[.userLevel6Minions] = savedDataMinions
        case 7:
            Defaults[.userLevel7Champions] = savedDataChampions
            Defaults[.userLevel7Towers] = savedDataTowers
            Defaults[.userLevel7Minions] = savedDataMinions
        case 8:
            Defaults[.userLevel8Champions] = savedDataChampions
            Defaults[.userLevel8Towers] = savedDataTowers
            Defaults[.userLevel8Minions] = savedDataMinions
        case 9:
            Defaults[.userLevel9Champions] = savedDataChampions
            Defaults[.userLevel9Towers] = savedDataTowers
            Defaults[.userLevel9Minions] = savedDataMinions
            
        default:
            Defaults[.userLevel0Champions] = savedDataChampions
            Defaults[.userLevel0Towers] = savedDataTowers
            Defaults[.userLevel0Minions] = savedDataMinions
        }
        
        print("Saved to User Defaults")
    }


}

extension DefaultsKeys {
    
    // pass or not
    static let levelPass = DefaultsKey<[Bool]>("levelPass", defaultValue: [false, false, false, false, false ,false, false, false, false, false])

    // level 0
    static let defaultLevel0Champions = DefaultsKey<[Int]>("defaultLevel0Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let defaultLevel0Towers = DefaultsKey<[Int]>("defaultLevel0Towers", defaultValue: [0,0,0,1,3,0,3,1,0,2,0,3,3,2,3,3,1,2,2,2])
    static let defaultLevel0Minions = DefaultsKey<[Int]>("defaultLevel0Minions", defaultValue: [0,4,1,3,2,3,3,4])
    static let userLevel0Champions = DefaultsKey<[Int]>("userLevel0Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let userLevel0Towers = DefaultsKey<[Int]>("userLevel0Towers", defaultValue: [0,0,0,1,3,0,3,1,0,2,0,3,3,2,3,3,1,2,2,2])
    static let userLevel0Minions = DefaultsKey<[Int]>("userLevel0Minions", defaultValue: [0,4,1,3,2,3,3,4])
    
    // level 1
    static let defaultLevel1Champions = DefaultsKey<[Int]>("defaultLevel1Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let defaultLevel1Towers = DefaultsKey<[Int]>("defaultLevel1Towers", defaultValue: [0,2,0,3,3,2,3,3])
    static let defaultLevel1Minions = DefaultsKey<[Int]>("defaultLevel1Minions", defaultValue: [0,0,0,1,3,0,3,1,1,2,1,3,2,2,2,3,0,4,3,4])
    static let userLevel1Champions = DefaultsKey<[Int]>("userLevel1Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let userLevel1Towers = DefaultsKey<[Int]>("userLevel1Towers", defaultValue: [0,2,0,3,3,2,3,3])
    static let userLevel1Minions = DefaultsKey<[Int]>("userLevel1Minions", defaultValue: [0,0,0,1,3,0,3,1,1,2,1,3,2,2,2,3,0,4,3,4])
    
    // level 2
    static let defaultLevel2Champions = DefaultsKey<[Int]>("defaultLevel2Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let defaultLevel2Towers = DefaultsKey<[Int]>("defaultLevel2Towers", defaultValue: [0,1,0,2,0,3,0,4])
    static let defaultLevel2Minions = DefaultsKey<[Int]>("defaultLevel2Minions", defaultValue: [0,0,3,0,3,1,3,2,1,2,2,2,1,3,2,3])
    static let userLevel2Champions = DefaultsKey<[Int]>("userLevel2Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let userLevel2Towers = DefaultsKey<[Int]>("userLevel2Towers", defaultValue: [0,1,0,2,0,3,0,4])
    static let userLevel2Minions = DefaultsKey<[Int]>("userLevel2Minions", defaultValue: [0,0,3,0,3,1,3,2,1,2,2,2,1,3,2,3])
    
    // level 3
    static let defaultLevel3Champions = DefaultsKey<[Int]>("defaultLevel3Champions", defaultValue: [2,1,3,1,2,2,3,2])
    static let defaultLevel3Towers = DefaultsKey<[Int]>("defaultLevel3Towers", defaultValue: [0,0,1,0,0,1,1,1,0,3,1,3,2,3,2,4,3,3,3,4])
    static let defaultLevel3Minions = DefaultsKey<[Int]>("defaultLevel3Minions", defaultValue: [2,0,3,0,0,2,1,2])
    static let userLevel3Champions = DefaultsKey<[Int]>("userLevel3Champions", defaultValue: [2,1,3,1,2,2,3,2])
    static let userLevel3Towers = DefaultsKey<[Int]>("userLevel3Towers", defaultValue: [0,0,1,0,0,1,1,1,0,3,1,3,2,3,2,4,3,3,3,4])
    static let userLevel3Minions = DefaultsKey<[Int]>("userLevel3Minions", defaultValue: [2,0,3,0,0,2,1,2])
    
    // level 4
    static let defaultLevel4Champions = DefaultsKey<[Int]>("defaultLevel4Champions", defaultValue: [0,1,1,1,0,2,1,2])
    static let defaultLevel4Towers = DefaultsKey<[Int]>("defaultLevel4Towers", defaultValue: [2,0,2,1,3,0,3,1,0,3,0,4,1,3,2,3,3,2,3,3,2,4,3,4])
    static let defaultLevel4Minions = DefaultsKey<[Int]>("defaultLevel4Minions", defaultValue: [0,0])
    static let userLevel4Champions = DefaultsKey<[Int]>("userLevel4Champions", defaultValue: [0,1,1,1,0,2,1,2])
    static let userLevel4Towers = DefaultsKey<[Int]>("userLevel4Towers", defaultValue: [2,0,2,1,3,0,3,1,0,3,0,4,1,3,2,3,3,2,3,3,2,4,3,4])
    static let userLevel4Minions = DefaultsKey<[Int]>("userLevel4Minions", defaultValue: [0,0])
    
    // level 5
    static let defaultLevel5Champions = DefaultsKey<[Int]>("defaultLevel5Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let defaultLevel5Towers = DefaultsKey<[Int]>("defaultLevel5Towers", defaultValue: [0,0,0,1,0,2,1,2,0,3,0,4,1,3,1,4,2,3,3,3])
    static let defaultLevel5Minions = DefaultsKey<[Int]>("defaultLevel5Minions", defaultValue: [2,2,3,2,2,4,3,4])
    static let userLevel5Champions = DefaultsKey<[Int]>("userLevel5Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let userLevel5Towers = DefaultsKey<[Int]>("userLevel5Towers", defaultValue: [0,0,0,1,0,2,1,2,0,3,0,4,1,3,1,4,2,3,3,3])
    static let userLevel5Minions = DefaultsKey<[Int]>("userLevel5Minions", defaultValue: [2,2,3,2,2,4,3,4])
    
    // level 6
    static let defaultLevel6Champions = DefaultsKey<[Int]>("defaultLevel6Champions", defaultValue: [2,2,3,2,2,3,3,3])
    static let defaultLevel6Towers = DefaultsKey<[Int]>("defaultLevel6Towers", defaultValue: [0,0,0,1,0,2,0,3,0,4,1,4,3,0,3,1,2,4,3,4])
    static let defaultLevel6Minions = DefaultsKey<[Int]>("defaultLevel6Minions", defaultValue: [1,2,1,0,2,0,2,1])
    static let userLevel6Champions = DefaultsKey<[Int]>("userLevel6Champions", defaultValue: [2,2,3,2,2,3,3,3])
    static let userLevel6Towers = DefaultsKey<[Int]>("userLevel6Towers", defaultValue: [0,0,0,1,0,2,0,3,0,4,1,4,3,0,3,1,2,4,3,4])
    static let userLevel6Minions = DefaultsKey<[Int]>("userLevel6Minions", defaultValue: [1,2,1,0,2,0,2,1])
    
    // level 7
    static let defaultLevel7Champions = DefaultsKey<[Int]>("defaultLevel7Champions", defaultValue: [0,2,1,2,0,3,1,3])
    static let defaultLevel7Towers = DefaultsKey<[Int]>("defaultLevel7Towers", defaultValue: [1,0,1,1,2,0,2,1,2,2,2,3,0,4,1,4,2,4,3,4])
    static let defaultLevel7Minions = DefaultsKey<[Int]>("defaultLevel7Minions", defaultValue: [3,1,3,2,0,0,0,1])
    static let userLevel7Champions = DefaultsKey<[Int]>("userLevel7Champions", defaultValue: [0,2,1,2,0,3,1,3])
    static let userLevel7Towers = DefaultsKey<[Int]>("userLevel7Towers", defaultValue: [1,0,1,1,2,0,2,1,2,2,2,3,0,4,1,4,2,4,3,4])
    static let userLevel7Minions = DefaultsKey<[Int]>("userLevel7Minions", defaultValue: [3,1,3,2,0,0,0,1])
    
    // level 8
    static let defaultLevel8Champions = DefaultsKey<[Int]>("defaultLevel8Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let defaultLevel8Towers = DefaultsKey<[Int]>("defaultLevel8Towers", defaultValue: [0,1,0,2,3,1,3,2,1,2,2,2,1,3,2,3,1,4,2,4])
    static let defaultLevel8Minions = DefaultsKey<[Int]>("defaultLevel8Minions", defaultValue: [0,0,3,0,0,3,3,3])
    static let userLevel8Champions = DefaultsKey<[Int]>("userLevel8Champions", defaultValue: [1,0,2,0,1,1,2,1])
    static let userLevel8Towers = DefaultsKey<[Int]>("userLevel8Towers", defaultValue: [0,1,0,2,3,1,3,2,1,2,2,2,1,3,2,3,1,4,2,4])
    static let userLevel8Minions = DefaultsKey<[Int]>("userLevel8Minions", defaultValue: [0,0,3,0,0,3,3,3])
    
    // level 9
    static let defaultLevel9Champions = DefaultsKey<[Int]>("defaultLevel9Champions", defaultValue: [0,1,1,1,0,2,1,2])
    static let defaultLevel9Towers = DefaultsKey<[Int]>("defaultLevel9Towers", defaultValue: [2,0,2,1,3,1,3,2,1,3,2,3,1,4,2,4,3,3,3,4])
    static let defaultLevel9Minions = DefaultsKey<[Int]>("defaultLevel9Minions", defaultValue: [1,0,3,0,2,2,0,3])
    static let userLevel9Champions = DefaultsKey<[Int]>("userLevel9Champions", defaultValue: [0,1,1,1,0,2,1,2])
    static let userLevel9Towers = DefaultsKey<[Int]>("userLevel9Towers", defaultValue: [2,0,2,1,3,1,3,2,1,3,2,3,1,4,2,4,3,3,3,4])
    static let userLevel9Minions = DefaultsKey<[Int]>("userLevel9Minions", defaultValue: [1,0,3,0,2,2,0,3])
    
}

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }


extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
