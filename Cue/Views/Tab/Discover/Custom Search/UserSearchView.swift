//
//  UserSearchView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import SwiftUI
import MusicKit

struct UserSearchView: View {
    
    @ObservedObject var nowPlayingModel: NowPlayingModel
    @ObservedObject var musicModel: MusicModel
    
    @StateObject var searchModel = SearchModel()
    
    @State private var searchField = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Artist, Song, Album", text: $searchField, onEditingChanged: {_ in
                    searchModel.songs = []
                    searchModel.albums = []
                    searchModel.artists = []
                }, onCommit: {
                    Task {
                        await searchModel.searchForAlbum(term: searchField)
                        await searchModel.searchForArtist(term: searchField)
                        await searchModel.searchForSong(term: searchField)
                    }
                })
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding()
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                if !searchField.isEmpty {
                    Button("Clear") {
                        searchField = ""
                    }
                    .foregroundColor(.brandPink)
                }
            }
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    if !searchModel.artists.isEmpty {
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Spacer()
                                    ForEach(searchModel.albums) { album in
                                        NavigationLink {
                                            SelectedAlbumView(album: album, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                        } label: {
                                            FetchedAlbumItem(item: album, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                        }
                                    }
                                }
                                Spacer()
                            }
                        } header: {
                            Text("Albums")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    if !searchModel.artists.isEmpty  {
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Spacer()
                                    ForEach(searchModel.artists) { artist in
                                        NavigationLink {
                                            SelectedArtistView(artist: artist, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                        } label: {
                                            FetchedArtistItem(artist: artist, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                        }
                                    }
                                }
                                Spacer()
                            }
                        } header: {
                            Text("Artists")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    if !searchModel.songs.isEmpty {
                        Section {
                            ForEach(searchModel.songs) { song in
                                NavigationLink {
                                    SelectedSongView(song: song, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                } label: {
                                    FetchedSongItem(item: song, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                }
                            }
                        } header: {
                            Text("Songs")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
            }
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserSearchView(nowPlayingModel: NowPlayingModel(), musicModel: MusicModel())
        }
    }
}
