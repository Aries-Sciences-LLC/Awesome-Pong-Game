//
//  DayTableViewCell.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLbl: UILabel!

    override func didMoveToSuperview() {
        contentLbl.layer.addSublayer(shadow())
    }
}

extension DayTableViewCell: TableViewCell {
    func configure(with data: Any) {
        guard let data = data as? String else {
            return
        }
        
        contentLbl.text = data
    }
    
    static var height: CGFloat {
        return 50
    }
}
