//
//  MenuVC.swift
//  Pong
//
//  Created by Burcu Mirza on 1/9/17.
//  Copyright © 2017 Burcu Mirza. All rights reserved.
//

import Foundation
import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
    case bluetooth
}

var deviceName : String = UIDevice.current.name

class MenuVC : UIViewController {
    
    @IBOutlet weak var mainTTL: UILabel!
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    override func viewDidLoad() {
        let x : CGFloat = 0
        var y: CGFloat = 100
        let width : CGFloat = self.view.frame.size.width
        let height : CGFloat = (self.view.frame.size.height - y) / 3
        
        easyBtn.frame = CGRect(x: x, y: y, width: width, height: height)
        y += height
        mediumBtn.frame = CGRect(x: x, y: y, width: width, height: height)
        y += height
        hardBtn.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
        
    }
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game

        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
