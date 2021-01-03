//
//  GameModeCollectionViewCell.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit
import ScalingCarousel

class GameModeCollectionViewCell: ScalingCarouselCell {
    static let reuseID: String = "GameModeCell"
    
    private let background = UIView()
    private let titleLbl = UILabel()
    
    public var handler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func didMoveToSuperview() {
        mainView = UIView(frame: contentView.bounds)
        contentView.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        mainView.layer.shadowOpacity = 0.9
        mainView.layer.shadowColor = UIColor.gray.cgColor
        mainView.layer.shadowRadius = 15
        
        background.frame = mainView.bounds
        background.layer.cornerRadius = background.bounds.height / 2
        background.layer.borderWidth = 12
        background.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        background.layer.insertSublayer(GradientsManager.shared.gradient(for: contentView.bounds, upon: traitCollection.userInterfaceStyle == .dark), at: 0)
        background.layer.masksToBounds = true
        background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(performSelection(_:))))
        mainView.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: mainView.topAnchor),
            background.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
        ])
        
        background.addSubview(titleLbl)
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: background.centerYAnchor),
        ])
    }
    
    override func layoutSubviews() {
       super.layoutSubviews()
    }
    
    func setTitle(to text: String) {
        titleLbl.text = text
        titleLbl.textColor = .secondaryLabel
        titleLbl.font = UIFont(name: "Avenir-Heavy", size: 17)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func performSelection(_ sender: Any!) {
        handler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
