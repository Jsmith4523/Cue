//
//  SelectedGenreView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/10/22.
//

import Foundation
import SwiftUI
import MusicKit


struct SelectedGenreView: View {
    
    let genre: MusicInterest
        
    @State private var displayBlack = false
    @State private var displayInlineTitle = false
        
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    @StateObject var searchModel = SearchModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    //MARK: Put no content in the below area
                    GenreArtwork(genre: genre, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
                    //MARK: Put no content in the above area
                    VStack {
                        if !displayInlineTitle {
                            HStack {
                                Text(genre.title)
                                    .customLargeNavTitle()
                                Spacer()
                            }
                            .frame(height: 50)
                            .padding()
                        }
                    }
                    Spacer()
                        .frame(height: 25)
                    //MARK: Albums
                    if !searchModel.albums.isEmpty {
                        ResultsOfAlbums(musicModel: musicModel, nowPlayingModel: nowPlayingModel, searchModel: searchModel)
                    }
                    
                    //MARK: Artist
                    if !searchModel.artists.isEmpty {
                        ResultsOfArtists(musicModel: musicModel, nowPlayingModel: nowPlayingModel, searchModel: searchModel)
                    }
                    
                    //MARK: Songs
                    if !searchModel.songs.isEmpty {
                        ResultsOfSongs(musicModel: musicModel, nowPlayingModel: nowPlayingModel, searchModel: searchModel)
                    }
                }
            }
            CustomNavigationBar(title: genre.title, dismiss: dismiss, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
        }
        .navigationBarHidden(true)
        .onAppear {
            if searchModel.songs.isEmpty {
                Task {
                    await searchModel.searchForSong(term: genre.title)
                }
            }
            if searchModel.albums.isEmpty {
                Task {
                    await searchModel.searchForAlbum(term: genre.title)
                }
            }
            if searchModel.artists.isEmpty {
                Task {
                    await searchModel.searchForArtist(term: genre.title)
                }
            }
        }
    }
    
    struct GenreArtwork: View {
        
        let genre: MusicInterest
        
        @State private var opacity: Double = 1
        
        @Binding var displayBlack: Bool
        @Binding var displayInlineTitle: Bool

        var body: some View {
            GeometryImage(url: genre.imageURL, showGradient: true, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
        }
    }
}
