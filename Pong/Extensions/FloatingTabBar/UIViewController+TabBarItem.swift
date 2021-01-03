//
//  UIViewController+TabBarItem.swift
//  Pong
//
//  Created by Ozan Mirza on 12/29/20.
//  Copyright © 2020 BurcuMirza. All rights reserved.
//

import UIKit

extension UIViewController {
    
    struct AssociatedKeys {
        static var floatingTabItem: UInt8 = 0
        static var floatingTabBarController: UInt8 = 1
    }
    
    @objc open var floatingTabItem: FloatingTabItem? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.floatingTabItem, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.floatingTabItem) as? FloatingTabItem
        }
    }
    
    @objc open var floatingTabBarController: FloatingTabBarController? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.floatingTabBarController, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.floatingTabBarController) as? FloatingTabBarController
        }
    }
    
}
