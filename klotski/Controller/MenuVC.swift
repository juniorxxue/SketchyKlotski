//
//  ViewController.swift
//  klotskiMenu
//
//  Created by Shawn Xu on 6/3/19.
//  Copyright © 2019 Nankai Univsity. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import SwiftyUserDefaults

class MenuVC: UIViewController, VerticalCardSwiperDelegate, VerticalCardSwiperDatasource{
    

    @IBOutlet weak var levelSelector: VerticalCardSwiper!
    
    private var levelsData: [Level] = [
        Level("LEVEL 0"),
        Level("LEVEL 1"),
        Level("LEVEL 2"),
        Level("LEVEL 3"),
        Level("LEVEL 4"),
        Level("LEVEL 5"),
        Level("LEVEL 6"),
        Level("LEVEL 7"),
        Level("LEVEL 8"),
        Level("LEVEL 9"),
        Level("About")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        levelSelector.delegate = self
        levelSelector.datasource = self
        
        levelSelector.register(nib: UINib(nibName: "LevelCard", bundle: nil), forCellWithReuseIdentifier: "LevelCard")
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        levelSelector.reloadData()
    }
    
    

    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        
        return levelsData.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let levelCard = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "LevelCard", for: index) as? LevelCard {
            
            if index == 10 {
                let level = levelsData[index]
                levelCard.setRandomBackgroundColor()
                levelCard.levelIndex.text = level.name
                levelCard.passImage.image = #imageLiteral(resourceName: "about")
                
                return levelCard
                
            }
            
            
//            levelsDetail = fetchCoreData()
            let level = levelsData[index]
            
            levelCard.setRandomBackgroundColor()
            levelCard.levelIndex.text = level.name
//            levelCard.playButton.setTitle(String(level.pass), for: .normal)
//            levelCard.playButton.setTitle(String(Defaults[.levelPass][index]), for: .normal)
            if Defaults[.levelPass][index] {
                levelCard.passImage.image = #imageLiteral(resourceName: "happy_face")
            } else {
                levelCard.passImage.image = #imageLiteral(resourceName: "neutral_face")
            }
            
            return levelCard
        }
        
        return LevelCard()
        
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        levelsData.remove(at: index)
    }
    
    func didSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called when a card has animated off screen entirely.
    }
    
    func didTapCard(verticalCardSwiperView: VerticalCardSwiperView, index: Int) {
        
        // Tells the delegate when the user taps a card (optional).
        
//        print("You tapped ", String(index))
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let gameVC = mainStoryboard.instantiateViewController(withIdentifier: "gamegame") as?
            GameVC else {
                print("Opps, couldn't find it")
                return
        }
        
        gameVC.levelChosen = index
        
        
//        levelsData[index].pass = true
//        Defaults[.levelPass][index] = true

        
        levelSelector.reloadData()
        
        
        
        navigationController?.pushViewController(gameVC, animated: true)
        
        
    }


}

