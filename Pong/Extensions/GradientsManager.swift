//
//  GradientsManager.swift
//  Pong
//
//  Created by Ozan Mirza on 12/30/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class GradientsManager {
    
    static var shared: GradientsManager = GradientsManager()
    
    private var colors: [[UIColor]]
    
    public init() {
        colors = []
        
        guard let path = Bundle.main.path(forResource: "Gradients", ofType: "json") else {
            fatalError("Cannot locate Gradients data...")
        }
        
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url, options: .mappedIfSafe)
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            for dict in json as! [[String: Any]] {
                colors.append((dict["colors"] as! [String]).map({ (hex) -> UIColor in
                    return UIColor(hex)
                }))
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    public func gradient(for size: CGRect, upon darkMode: Bool) -> CAGradientLayer {
        let gl = CAGradientLayer()
        gl.colors = colors[Int.random(in: 0..<colors.count)].map({ (color) -> CGColor in
            if darkMode {
                return color.darker().cgColor
            }
            return color.cgColor
        })
        gl.locations = [0.0, 0.6]
        gl.frame = size
        gl.startPoint = .zero
        gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.type = .axial
        return gl
    }
}
