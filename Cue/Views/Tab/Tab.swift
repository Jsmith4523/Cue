//
//  ContentView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI
import MusicKit

struct MainTabView: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    @ObservedObject var favoritesModel: FavoritesModel
    
    var body: some View {
        TabView(selection: $musicModel.index) {
            Discover(musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                .tag(0)
                .tabItem {
                    Label("Discover", systemImage: "music.mic")
                }
//            Color.red
//                .tag(1)
//                .tabItem {
//                    Label("Me", systemImage: "person.circle")
//                }
            Settings(musicModel: musicModel)
                .tag(2)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .accentColor(.brandPink)
    }
}
