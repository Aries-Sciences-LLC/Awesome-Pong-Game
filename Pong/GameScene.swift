//
//  GameScene.swift
//  Pong
//
//  Created by Burcu Mirza on 10/11/16.
//  Copyright © 2016 Burcu Mirza. All rights reserved.
//

import SpriteKit
import GameplayKit
import MultipeerConnectivity

class GameScene: SKScene, MCSessionDelegate, MCBrowserViewControllerDelegate {

    var currentViewController : UIViewController = UIApplication.shared.keyWindow!.rootViewController!
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    var peerID : MCPeerID!
    var mcSession : MCSession!
    var mcAdvertiserAssistant : MCAdvertiserAssistant!
    var mcBrowser : MCBrowserViewController!
    
    override func didMove(to view: SKView) {
 
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        if currentGameType != .bluetooth {
            self.startGame()
        } else {
            self.peerID = MCPeerID(displayName: deviceName)
            self.setUpConnectivity()
        }
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
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(self.getImpulse(isNegative: true))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
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
    
    @IBAction func exit(_ sender: UIButton) {
        if currentGameType == .bluetooth {
            do {
                try mcSession.send(Data(base64Encoded: "Canceled")!, toPeers: mcSession.connectedPeers, with: .reliable)
            } catch let error as NSError {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
        
        let gameVC = self.currentViewController.storyboard?.instantiateViewController(withIdentifier: currentGameType == .bluetooth || currentGameType == .player2 ? "MultiplayerViewController" : "SinglePlayerViewController")
        self.currentViewController.navigationController?.pushViewController(gameVC!, animated: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
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
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.9))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .player2:
            break
        case .bluetooth:
            break
        }
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
    
    func getRandomImpulse() -> CGVector {
        let decider = Int.random(in: 0..<2)
        if decider == 0 {
            return CGVector(dx: 10, dy: 10)
        }
        
        return CGVector(dx: -10, dy: -10)
    }
    
    func getImpulse(isNegative: Bool) -> CGVector {
        if isNegative {
            return CGVector(dx: -10, dy: -10)
        }
        
        return CGVector(dx: 10, dy: 10)
    }
    
    func setUpConnectivity() {
        let bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        bg.frame = self.view!.bounds
        bg.alpha = 0
        self.view!.addSubview(bg)
        self.mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        self.mcSession.delegate = self
        self.mcBrowser = MCBrowserViewController(serviceType: "BurcuMirza-Pong", session: self.mcSession)
        self.mcBrowser.delegate = self
        UIView.animate(withDuration: 0.5, animations: {
            bg.alpha = 1
        }) { _ in
            let actionSheet = UIAlertController(title: "Create Game", message: "Do you want to Host or Join a game?", preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Host Game", style: .default, handler: { (action:UIAlertAction) in
                self.mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "BurcuMirza-Pong", discoveryInfo: nil, session: self.mcSession)
                self.mcAdvertiserAssistant.start()
                let bg_sub = UIView(frame: CGRect(x: 0, y: -300, width: 300, height: 300))
                bg_sub.center.x = bg.center.x
                bg_sub.backgroundColor = UIColor(red: (244 / 255), green: (66 / 255), blue: (66 / 255), alpha: 1)
                bg_sub.layer.cornerRadius = 20
                bg.contentView.addSubview(bg_sub)
                let ttl = UILabel(frame: CGRect(x: 16, y: 20, width: bg_sub.frame.size.width - 32, height: 50))
                ttl.font = ttl.font.withSize(35)
                ttl.text = "Hosting Game"
                ttl.textColor = UIColor.white
                ttl.textAlignment = NSTextAlignment.center
                bg_sub.addSubview(ttl)
                let subttl = UILabel(frame: CGRect(x: 16, y: 78, width: bg_sub.frame.size.width - 32, height: 50))
                subttl.font = ttl.font.withSize(20)
                subttl.text = "Please wait until someone joins your game."
                subttl.textColor = UIColor.white
                subttl.textAlignment = NSTextAlignment.center
                subttl.numberOfLines = 2
                bg_sub.addSubview(subttl)
                let indicator_bg = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
                indicator_bg.frame.size = CGSize(width: 50, height: 50)
                indicator_bg.center.y = bg_sub.frame.size.height / 2 + 25
                indicator_bg.center.x = bg_sub.frame.size.width / 2
                indicator_bg.layer.cornerRadius = 10
                indicator_bg.layer.masksToBounds = true
                bg_sub.addSubview(indicator_bg)
                let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
                indicator.center.y = indicator_bg.frame.size.height / 2
                indicator.center.x = indicator_bg.frame.size.width / 2
                indicator.startAnimating()
                indicator_bg.contentView.addSubview(indicator)
                UIView.animate(withDuration: 0.5, animations: {
                    bg_sub.center = bg.center
                })
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Join Game", style: .default, handler: { (action:UIAlertAction) in
                self.currentViewController.present(self.mcBrowser, animated: true, completion: nil)
            }))
            
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                let gameVC = self.currentViewController.storyboard?.instantiateViewController(withIdentifier: "Multiplayer") as! MultiMenuVC
                self.currentViewController.navigationController?.pushViewController(gameVC, animated: true)
            }))
            
            self.currentViewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    public func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true) {
            let gameVC = self.currentViewController.storyboard?.instantiateViewController(withIdentifier: "Multiplayer") as! MultiMenuVC
            self.currentViewController.navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    
    public func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true) {
            UIView.animate(withDuration: 0.5, animations: {
                self.view!.subviews.last!.alpha = 0
            })
        }
    }
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if data.base64EncodedData() == Data(base64Encoded: "Canceled") {
            let alert = UIAlertController(title: "Yay!", message: "\(peerID.displayName) forfeited!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.exit(UIButton())
            }))
            self.currentViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.mcBrowser.dismiss(animated: true) {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, animations: {
                            (self.view!.subviews.last! as? UIVisualEffectView)!.subviews[0].backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (178 / 255), alpha: 1)
                        }) { _ in
                            UIView.animate(withDuration: 0.5, animations: {
                                self.view!.subviews.last!.alpha = 0
                            }, completion: { _ in
                                let bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
                                bg.frame = self.view!.bounds
                                bg.alpha = 0
                                self.view!.addSubview(bg)
                                let lbl = UILabel(frame: CGRect(x: 0, y: -100, width: 100, height: 100))
                                lbl.center.x = self.view!.center.x
                                lbl.font = lbl.font.withSize(45)
                                lbl.text = "3"
                                lbl.textColor = UIColor.black
                                lbl.textAlignment = NSTextAlignment.center
                                lbl.backgroundColor = UIColor.white
                                lbl.layer.cornerRadius = 50
                                lbl.layer.masksToBounds = true
                                lbl.layer.borderColor = UIColor.black.cgColor
                                lbl.layer.borderWidth = 5
                                bg.contentView.addSubview(lbl)
                                UIView.animate(withDuration: 0.5, animations: {
                                    bg.alpha = 1
                                }) { _ in
                                    UIView.animate(withDuration: 0.5, animations: {
                                        lbl.center = self.view!.center
                                    }, completion: { _ in
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                            UIView.animate(withDuration: 0.5, animations: {
                                                lbl.frame.origin.y = bg.frame.size.height
                                            }, completion: { _ in
                                                lbl.text = "2"
                                                lbl.frame.origin.y = -100
                                                UIView.animate(withDuration: 0.5, animations: {
                                                    lbl.center = self.view!.center
                                                }, completion: { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                                        UIView.animate(withDuration: 0.5, animations: {
                                                            lbl.frame.origin.y = bg.frame.size.height
                                                        }, completion: { _ in
                                                            lbl.text = "1"
                                                            lbl.frame.origin.y = -100
                                                            UIView.animate(withDuration: 0.5, animations: {
                                                                lbl.center = self.view!.center
                                                            }, completion: { _ in
                                                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                                                    UIView.animate(withDuration: 0.5, animations: {
                                                                        lbl.frame.origin.y = bg.frame.size.height
                                                                    }, completion: { _ in
                                                                        UIView.animate(withDuration: 0.5, animations: {
                                                                            bg.alpha = 0
                                                                        })
                                                                    })
                                                                })
                                                            })
                                                        })
                                                    })
                                                })
                                            })
                                        })
                                    })
                                }
                            })
                        }
                    }
                }
            }
        case .connecting:
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.5) {
                    self.view!.subviews.last!.subviews[0].backgroundColor = UIColor(red: (249 / 255), green: (249 / 255), blue: (187 / 255), alpha: 1)
                }
            }
        case .notConnected:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Uh-Oh", message: "Connection to \(peerID.displayName) is not available right now.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.exit(UIButton())
                }))
                self.currentViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
}
