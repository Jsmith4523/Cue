//
//  ResultsOfSongs.swift
//  Cue
//
//  Created by Jaylen Smith on 10/14/22.
//

import SwiftUI
import MusicKit

struct ResultsOfArtists: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    @ObservedObject var searchModel: SearchModel
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    ForEach(searchModel.artists.sorted(by: <)) { artist in
                        NavigationLink {
                          SelectedArtistView(artist: artist, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        } label: {
                            FetchedArtistItem(artist: artist, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        }
                    }
                    Spacer()
                }
            }
        } header: {
            HStack {
                Text("Artists")
                    .navigationHeaderStyle()
                Spacer()
            }
            .padding()
        }
    }
}

