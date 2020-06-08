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

var currentGameType = gameType.medium

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    @IBAction func exit(_ sender: UIButton) {
        ((self.view as! SKView).scene as! GameScene).currentViewController = self
        ((self.view as! SKView).scene as! GameScene).exit(sender)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
