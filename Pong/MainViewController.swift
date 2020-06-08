//
//  MainViewController.swift
//  Pong
//
//  Created by Burcu Mirza on 3/4/19.
//  Copyright © 2019 BurcuMirza. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTtl: UILabel!
    @IBOutlet weak var singlePlayerBtn: UIButton!
    @IBOutlet weak var multiplayerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let x : CGFloat = 0
        let y: CGFloat = 100
        let width : CGFloat = self.view.frame.size.width
        let height : CGFloat = (self.view.frame.size.height - y) / 2
        
        singlePlayerBtn.frame = CGRect(x: x, y: y, width: width, height: height)
        multiplayerBtn.frame = CGRect(x: x, y: y + singlePlayerBtn.frame.size.height, width: width, height: height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
