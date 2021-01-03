//
//  Array.swift
//  Pong
//
//  Created by Ozan Mirza on 1/2/21.
//  Copyright © 2021 BurcuMirza. All rights reserved.
//

import Foundation

extension Array {
    func adding(_ element: Element, afterEvery n: Int) -> [Element] {
        guard n > 0 else { fatalError("afterEvery value must be greater than 0") }
        let newcount = self.count + self.count / n
        return (0 ..< newcount).map { (i: Int) -> Element in
            (i + 1) % (n + 1) == 0 ? element : self[i - i / (n + 1)]
        }
    }
}
