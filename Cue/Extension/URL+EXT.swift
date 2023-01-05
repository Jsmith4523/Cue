//
//  URL+EXT.swift
//  Cue
//
//  Created by Jaylen Smith on 11/1/22.
//

import Foundation
import SwiftUI
import UIKit


extension URL {
    
    static func openCueSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    static func openUrlToAppleMusic(_ url: URL?, didThrowError: inout Bool) {
        guard let url = url else {
            didThrowError = true
            return
        }
        
        UIApplication.shared.open(url)
    }
}
