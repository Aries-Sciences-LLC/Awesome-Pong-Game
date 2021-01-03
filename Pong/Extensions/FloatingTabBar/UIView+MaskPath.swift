//
//  UIView + MaskPath.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension UIView {
    
    @objc var maskPath: UIBezierPath? {
        set {
            let shapeLayer = (layer.mask as? CAShapeLayer) ?? CAShapeLayer()
            shapeLayer.path = newValue?.cgPath
            layer.mask = shapeLayer
        }
        get {
            guard let shapeLayer = layer.mask as? CAShapeLayer, let path = shapeLayer.path else {
                return nil
            }
            return UIBezierPath(cgPath: path)
        }
    }
    
}
