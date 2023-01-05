//
//  ResultsOfSongs.swift
//  Cue
//
//  Created by Jaylen Smith on 10/14/22.
//

import SwiftUI
import MusicKit

struct ResultsOfSongs: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    @ObservedObject var searchModel: SearchModel
    
    var body: some View {
        Section {
            ForEach(searchModel.songs.sorted(by: <)) { song in
                NavigationLink {
                   SelectedSongView(song: song, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                } label: {
                    FetchedSongItem(item: song, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                }
            }
        } header: {
            HStack {
                Text("Songs")
                    .navigationHeaderStyle()
                Spacer()
            }
            .padding()
        }
    }
}

