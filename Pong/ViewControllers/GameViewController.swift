//
//  GameViewController.swift
//  Pong
//
//  Created by Burcu Mirza on 10/11/16.
//  Copyright © 2016 Burcu Mirza. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import ScalingCarousel

class GameViewController: UIViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var gameView: SKView!
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    
    @IBOutlet weak var gameModeSelector: ScalingCarouselView!
    @IBOutlet weak var popOver: UIView!
    @IBOutlet weak var popOverY: NSLayoutConstraint!
    @IBOutlet weak var popOverShadow: UIView!
    
    var currentGameType: GameMode!
    var currentGameSection: Section!
    var gameScene: GameScene!
    
    var duration: TimeInterval!
    var timer: Timer!
    var timestamp: Date!
    var scores: Scores!
    
    let modes = ["EASY", "MEDIUM", "HARD", "2 PLAYER"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameModeSelector.register(GameModeCollectionViewCell.self, forCellWithReuseIdentifier: GameModeCollectionViewCell.reuseID)
        gameModeSelector.inset = 75
        let dimension = view.bounds.width * 0.3
        gameModeSelector.contentSize = CGSize(width: dimension, height: dimension)
        
        popOverShadow.layer.shadowColor = UIColor.label.cgColor
        popOverShadow.layer.shadowRadius = 15
        popOverShadow.layer.shadowOpacity = 0.7
        
        popOver.layer.cornerRadius = 15
        popOver.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        shadowView.layer.shadowOpacity = 0.9
        shadowView.layer.shadowColor = UIColor.gray.cgColor
        shadowView.layer.shadowRadius = 20
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 5)
        
        gameView.layer.borderColor = UIColor.label.cgColor
        
        restartBtn.layer.shadowColor = UIColor.black.cgColor
        restartBtn.layer.shadowOffset = CGSize(width: 2, height: 5)
        restartBtn.layer.shadowRadius = 15
        restartBtn.layer.shadowOpacity = 1
        
        saveBtn.layer.shadowColor = UIColor.black.cgColor
        saveBtn.layer.shadowOffset = CGSize(width: 2, height: 5)
        saveBtn.layer.shadowRadius = 15
        saveBtn.layer.shadowOpacity = 1
        
        createGame(nil)
    }
    
    func importUI() {
        if let view = gameView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene {
                gameScene = scene
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.size = view.bounds.size
                
                scene.gameDelegate = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
    }
    
    func startGame() {
        importUI()
        floatingTabBarController?.scrollView.isScrollEnabled = false
        popOverY.constant = -350
        UIView.animate(withDuration: 0.3, animations: { [self] in
            view.layoutIfNeeded()
        }) { [self] _ in
            gameScene.commence()
            duration = 0
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self] timer in
                duration += 1.0
            })
            timestamp = Date()
            scores = Scores(opponent: 0, player: 0)
        }
    }
    
    @IBAction func createGame(_ sender: UIButton!) {
        floatingTabBarController?.scrollView.isScrollEnabled = true
        importUI()
        popOverY.constant = 0
        UIView.animate(withDuration: 0.3) { [self] in
            view.layoutIfNeeded()
        }
    }
    
    @IBAction func save(_ sender: UIButton!) {
        if duration != nil && timestamp != nil && scores != nil {
            let contents = Game(duration: duration, timestamp: timestamp, scores: scores, mode: currentGameType)
            History.shared.add(game: contents, for: currentGameSection)
            
            floatingTabBarController?.viewControllers.forEach({ (controller) in
                if let navController = controller as? UINavigationController {
                    navController.viewControllers.first?.viewDidAppear(true)
                }
            })
            createGame(sender)
        }
    }
}

extension GameViewController: GameSceneDelegate {
    func getDeviceName() -> String {
        return UIDevice.current.name
    }
    
    func getParentVC() -> GameViewController {
        return self
    }
    
    func getMode() -> GameMode {
        return currentGameType
    }
    
    func shouldUpdateScores(with opponent: Int, and player: Int) {
        scores = Scores(opponent: opponent, player: player)
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameModeCollectionViewCell.reuseID, for: indexPath) as! GameModeCollectionViewCell
        let mode = modes[indexPath.item]
        cell.setTitle(to: mode)
        cell.handler = { [self] in
            currentGameType = GameMode(rawValue: mode)
            switch mode {
            case "2 PLAYER":
                currentGameSection = .multi
            default:
                currentGameSection = .single
            }
            
            startGame()
        }
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gameModeSelector.didScroll()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 135)
    }
}
