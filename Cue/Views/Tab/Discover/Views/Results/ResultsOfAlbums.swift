//
//  ResultsOfAlbums.swift
//  Cue
//
//  Created by Jaylen Smith on 10/14/22.
//

import SwiftUI
import MusicKit

struct ResultsOfAlbums: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    @ObservedObject var searchModel: SearchModel
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                    ForEach(searchModel.albums.sorted(by: <)) { album in
                        NavigationLink {
                            SelectedAlbumView(album: album, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        } label: {
                            FetchedAlbumItem(item: album, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        }
                    }
                    Spacer()
                }
            }
        } header: {
            HStack {
                Text("Albums")
                    .navigationHeaderStyle()
                Spacer()
            }
            .padding()
        }
    }
}
