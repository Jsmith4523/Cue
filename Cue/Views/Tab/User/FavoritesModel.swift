//
//  FavoritesModel.swift
//  Cue
//
//  Created by Jaylen Smith on 10/27/22.
//

import Foundation
import SwiftUI
import MusicKit

class FavoritesModel: ObservableObject {
    
    @Published var favoriteSongs = [SongItem]()
    
    init() {
        
    }
}
