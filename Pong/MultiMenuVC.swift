//
//  MultiMenuVC.swift
//  Pong
//
//  Created by Burcu Mirza on 3/4/19.
//  Copyright © 2019 BurcuMirza. All rights reserved.
//

import UIKit

class MultiMenuVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mainTTL: UILabel!
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var bluetoothBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let x : CGFloat = 0
        let y: CGFloat = 100
        let width : CGFloat = self.view.frame.size.width
        let height : CGFloat = (self.view.frame.size.height - y) / 2
        
        localBtn.frame = CGRect(x: x, y: y, width: width, height: height)
        bluetoothBtn.frame = CGRect(x: x, y: y + localBtn.frame.size.height, width: width, height: height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createLocalGame(_ sender: UIButton) {
        let bg = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        bg.frame = self.view.bounds
        bg.alpha = 0
        self.view.addSubview(bg)
        let lbl = UILabel(frame: CGRect(x: 0, y: -100, width: 100, height: 100))
        lbl.center.x = self.view.center.x
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
                lbl.center = self.view.center
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        lbl.frame.origin.y = bg.frame.size.height
                    }, completion: { _ in
                        lbl.text = "2"
                        lbl.frame.origin.y = -100
                        UIView.animate(withDuration: 0.5, animations: {
                            lbl.center = self.view.center
                        }, completion: { _ in
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                UIView.animate(withDuration: 0.5, animations: {
                                    lbl.frame.origin.y = bg.frame.size.height
                                }, completion: { _ in
                                    lbl.text = "1"
                                    lbl.frame.origin.y = -100
                                    UIView.animate(withDuration: 0.5, animations: {
                                        lbl.center = self.view.center
                                    }, completion: { _ in
                                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                                            UIView.animate(withDuration: 0.5, animations: {
                                                lbl.frame.origin.y = bg.frame.size.height
                                            }, completion: { _ in
                                                let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
                                                currentGameType = .player2
                                                self.navigationController?.pushViewController(gameVC, animated: true)
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
    }

    @IBAction func createBluetoothGame(_ sender: UIButton) {
        let bg = UIVisualEffectView(frame: self.view.bounds)
        bg.effect = UIBlurEffect(style: .dark)
        bg.alpha = 0
        self.view.addSubview(bg)
        let bg_sub = UITextField(frame: CGRect(x: 0, y: -300, width: self.view.frame.size.width, height: 300))
        bg_sub.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (235 / 255), alpha: 1)
        bg_sub.textColor = UIColor.white
        bg_sub.textAlignment = NSTextAlignment.center
        bg_sub.delegate = self
        bg_sub.font = bg_sub.font?.withSize(60)
        UITextField.appearance().tintColor = UIColor.white
        bg.contentView.addSubview(bg_sub)
        UIView.animate(withDuration: 0.5, animations: {
            bg.alpha = 1
            bg_sub.frame.origin.y = 0
        }) { _ in
            bg_sub.becomeFirstResponder()
            let cancelBtn = UIButton(frame: CGRect(x: 16, y: 265, width: (self.view.frame.size.width / 2) - 32, height: 35))
            cancelBtn.backgroundColor = UIColor(red: (244 / 255), green: (66 / 255), blue: (66 / 255), alpha: 1)
            cancelBtn.layer.cornerRadius = cancelBtn.frame.size.height / 2
            cancelBtn.setImage(UIImage(named: "exit_icon"), for: .normal)
            cancelBtn.setTitleColor(UIColor.white, for: .normal)
            cancelBtn.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
            cancelBtn.titleLabel?.font = cancelBtn.titleLabel?.font.withSize(25)
            cancelBtn.addTarget(self, action: #selector(self.exitMenu(_:)), for: .touchUpInside)
            bg.contentView.insertSubview(cancelBtn, at: 0)
            let okBtn = UIButton(frame: CGRect(x: self.view.frame.size.width - (self.view.frame.size.width / 2) + 16, y: 265, width: (self.view.frame.size.width / 2) - 32, height: 35))
            okBtn.backgroundColor = UIColor(red: (66 / 255), green: (244 / 255), blue: (178 / 255), alpha: 1)
            okBtn.layer.cornerRadius = okBtn.frame.size.height / 2
            okBtn.setImage(UIImage(named: "checkmark"), for: .normal)
            okBtn.setTitleColor(UIColor.white, for: .normal)
            okBtn.titleLabel?.font = okBtn.titleLabel?.font.withSize(25)
            okBtn.addTarget(self, action: #selector(self.activateBluetooth(_:)), for: .touchUpInside)
            bg.contentView.insertSubview(okBtn, at: 0)
            UIView.animate(withDuration: 0.5) {
                cancelBtn.frame.origin.y = 302
                okBtn.frame.origin.y = 302
            }
        }
    }
    
    @objc func exitMenu(_ sender: UIButton!) {
        UIView.animate(withDuration: 0.5) {
            sender.superview!.superview!.alpha = 0
        }
    }
    
    @objc func activateBluetooth(_ sender: UIButton!) {
        deviceName = (sender.superview!.subviews.last! as? UITextField)!.text!
        UIView.animate(withDuration: 0.5) {
            sender.superview!.superview!.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            currentGameType = .bluetooth
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
