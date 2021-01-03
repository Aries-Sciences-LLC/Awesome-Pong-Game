//
//  GameScene.swift
//  Pong
//
//  Created by Burcu Mirza on 10/11/16.
//  Copyright © 2016 Burcu Mirza. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

protocol GameSceneDelegate {
    func getParentVC() -> GameViewController
    func getMode() -> GameMode
    func getDeviceName() -> String
    func shouldUpdateScores(with opponent: Int, and player: Int)
}

enum GameMode: String, Codable {
    case easy = "EASY"
    case medium = "MEDIUM"
    case hard = "HARD"
    case local = "2 PLAYER"
}

class GameScene: SKScene {
    var gameDelegate : GameSceneDelegate?
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    var motionManager: CMMotionManager!
    
    var running: Bool!
    
    override func didMove(to view: SKView) {
 
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        let spacing: CGFloat = 3
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = frame.size.height / spacing
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = -frame.size.height / spacing
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        running = false
    }
    
    func commence() {
        running = true
        self.startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.ball.physicsBody?.applyImpulse(self.getRandomImpulse())
        }
    }
    
    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(self.getImpulse(isNegative: false))
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(self.getImpulse(isNegative: true))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
        gameDelegate?.shouldUpdateScores(with: score[1], and: score[0])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if running {
            for touch in touches {
                let location = touch.location(in: self)
                
                if gameDelegate?.getMode() == .local {
                    if location.y > 0 {
                        enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    } else {
                        main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    }
                } else {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if running {
            for touch in touches {
                let location = touch.location(in: self)
                
                if gameDelegate?.getMode() == .local {
                    if location.y > 0 {
                        enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                    }
                    if location.y < 0 {
                        
                        main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                        
                    }

                }
                else{
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if running {
            switch gameDelegate?.getMode() {
            case .easy:
                enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.9))
                break
            case .medium:
                enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
                break
            case .hard:
                enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
                break
            case .local:
                break
            case .none:
                break
            }
            
            if ball.position.y <= main.position.y - 30 {
                addScore(playerWhoWon: enemy)
            }
            else if ball.position.y >= enemy.position.y + 30 {
                addScore(playerWhoWon: main)
            }
            
            if gameDelegate?.getMode() != .local {
                if let accelerometerData = motionManager.accelerometerData {
                    main.run(.move(by: CGVector(dx: accelerometerData.acceleration.x * 10, dy: 0), duration: 0.2))
                }
            }
        }
    }
    
    func getRandomImpulse() -> CGVector {
        return CGVector(dx: Int.random(in: 5 ..< 15), dy: Int.random(in: 5 ..< 15))
    }
    
    func getImpulse(isNegative: Bool) -> CGVector {
        return CGVector(dx: Int.random(in: -15 ..< -5), dy: Int.random(in: -15 ..< -5))
    }
}
