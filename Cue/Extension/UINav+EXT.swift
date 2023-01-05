//
//  UINav+EXT.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import Foundation
import UIKit
import SwiftUI

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(Color.brandPink)
        
    }
}

extension UITabBarController {
    
    open override func viewDidLoad() {
        self.tabBar.unselectedItemTintColor = .white
    }
}
