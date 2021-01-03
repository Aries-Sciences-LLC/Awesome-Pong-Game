//
//  AdTableViewCell.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    
    var banner: GADBannerView!

    override func didMoveToSuperview() {
        container.addSubview(banner)
        
        banner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            banner.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            banner.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
    }
}

extension AdTableViewCell: TableViewCell {
    func configure(with data: Any) {
        banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-7352520433824678/4813129786"
        banner.rootViewController = data as? UIViewController
        banner.load(GADRequest())
    }
    
    static var height: CGFloat {
        return 68
    }
}
