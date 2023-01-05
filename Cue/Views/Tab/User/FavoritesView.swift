//
//  LibraryView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/14/22.
//

import SwiftUI
import MusicKit

struct Favorites: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        NavigationView {
            switch (musicModel.savedRecentlyListenedSongs.isEmpty, musicModel.savedRecentlyListenedAlbums.isEmpty, musicModel.savedRecentlyListenedArtists.isEmpty) {
            case (true, true, true):
                BeginExploringView(musicModel: musicModel, nowPlayingModel: nowPlayingModel)
            default:
               SavedFavoritesView(musicModel: musicModel, nowPlayingModel: nowPlayingModel)
            }
        }
    }
    
    struct SavedFavoritesView: View {
        
        @ObservedObject var musicModel: MusicModel
        @ObservedObject var nowPlayingModel: NowPlayingModel
        
        var body: some View {
            VStack {
                
            }
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites(musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
    }
}
