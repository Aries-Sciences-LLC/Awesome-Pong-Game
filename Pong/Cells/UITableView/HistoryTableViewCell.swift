//
//  HistoryTableViewCell.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var winningScore: UILabel!
    @IBOutlet weak var losingScore: UILabel!
    @IBOutlet weak var mode: UILabel!
    
    var gradient: CAGradientLayer!

    override func didMoveToSuperview() {
        shadowView.layer.addSublayer(shadow())
        title.layer.addSublayer(shadow())
        duration.layer.addSublayer(shadow())
        winningScore.layer.addSublayer(shadow())
        losingScore.layer.addSublayer(shadow())
        mode.layer.addSublayer(shadow())
        
        background.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        background.layer.sublayers?.forEach({ sublayer in
            if sublayer is CAGradientLayer {
                sublayer.removeFromSuperlayer()
            }
        })
        gradient = GradientsManager.shared.gradient(for: background.bounds, upon: traitCollection.userInterfaceStyle == .dark)
        background.layer.insertSublayer(gradient, at: 0)
    }
}

extension HistoryTableViewCell: TableViewCell {
    func configure(with data: Any) {
        guard let data = data as? Game else {
            return
        }
        
        title.text = data.scores.won != nil ? (data.scores.won! ? "WIN" : "LOSS") : "DRAW"
        duration.text = "Duration of \(data.duration.string)"
        winningScore.text = "\(data.scores.winningScore)"
        losingScore.text = "\(data.scores.losingScore)"
        mode.text = "\(data.mode.rawValue)"
    }
    
    static var height: CGFloat {
        return 220
    }
}
