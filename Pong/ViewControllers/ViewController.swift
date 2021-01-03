//
//  ViewController.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

class ViewController: FloatingTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let navSingle = storyboard!.instantiateViewController(withIdentifier: "navSingle") as! UINavigationController
        navSingle.floatingTabItem = FloatingTabItem(
            selectedImage: UIImage(systemName: "person.fill")!,
            normalImage: UIImage(systemName: "person")!
        )
        
        let navMulti = storyboard!.instantiateViewController(withIdentifier: "navMulti") as! UINavigationController
        navMulti.floatingTabItem = FloatingTabItem(
            selectedImage: UIImage(systemName: "person.2.fill")!,
            normalImage: UIImage(systemName: "person.2")!
        )
        
        let game = storyboard!.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        game.floatingTabItem = FloatingTabItem(
            selectedImage: UIImage(systemName: "play.fill")!,
            normalImage: UIImage(systemName: "play")!
        )
        
        viewControllers = [navSingle, navMulti, game]
    }
}
