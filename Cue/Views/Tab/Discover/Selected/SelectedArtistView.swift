//
//  SelectedArtistView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/12/22.
//

import SwiftUI
import MusicKit

struct SelectedArtistView: View {
    
    let artist: ArtistItem
    
    @State private var albums = [AlbumItem]()
    
    @State private var displayBlack = false
    @State private var displayInlineTitle = false
    
    @State private var didThrowError = false
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    @StateObject private var searchModel = SearchModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryImage(url: artist.artwork, showGradient: true, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
                VStack(spacing: 10) {
                    Text(artist.name)
                        .customLargeNavTitle()
                    Button {
                        URL.openUrlToAppleMusic(artist.url, didThrowError: &didThrowError)
                    } label: {
                        Label {
                            Text("Music")
                        } icon: {
                            Image(systemName: "applelogo")
                        }
                    }
                }
            }
            CustomNavigationBar(title: artist.name, dismiss: self.dismiss, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
        }
        .navigationBarHidden(true)
        .alert("Well, this sucks", isPresented: $didThrowError, actions: {}, message: {
            Text("That link is broken")
        })
        .onAppear {
            if searchModel.songs.isEmpty {
                Task {
                    await searchModel.searchForSong(term: artist.name)
                }
            }
            if searchModel.albums.isEmpty {
                Task {
                    await searchModel.searchForAlbum(term: artist.name)
                }
            }
            Task {
                self.albums = await artist.albums()
            }
        }
    }
}

struct Previews_SelectedArtistView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedArtistView(artist: ArtistItem(id: .init("43"), name: "Beyonce"), musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
    }
}
