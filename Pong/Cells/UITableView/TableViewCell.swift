//
//  CollectionViewCell.swift
//  Pong
//
//  Created by Ozan Mirza on 1/2/21.
//  Copyright © 2021 BurcuMirza. All rights reserved.
//

import UIKit

protocol TableViewCell {
    static var height: CGFloat { get }
    func configure(with data: Any)
}
