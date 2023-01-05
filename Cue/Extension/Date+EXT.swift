//
//  Date+EXT.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import Foundation
import SwiftUI

extension Date {
    func long() -> String {
        return self
            .formatted(date: .long, time: .omitted)
    }
}
