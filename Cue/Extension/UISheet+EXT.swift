//
//  UISheet+EXT.swift
//  Cue
//
//  Created by Jaylen Smith on 10/25/22.
//

import Foundation
import UIKit
import SwiftUI
import Swift

extension UISheetPresentationController {
    
    open override func containerViewDidLayoutSubviews() {
        //Will set the standard corner radius of a sheet to 35 once layed out...
        self.preferredCornerRadius = 35
        
        if !(self.presentedViewController.isModalInPresentation) {
            self.prefersGrabberVisible = true
        }
    }
}
