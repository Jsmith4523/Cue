//
//  SelectedSongFromGenreView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/10/22.
//

import SwiftUI
import MusicKit

struct SelectedAlbumView: View {
    
    var album: AlbumItem
    
    @State private var displayBlack = false
    @State private var displayInlineTitle = false
    
    @State private var tracks = [SongItem]()
    @State private var relatedAlbums = [AlbumItem]()
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    @StateObject var searchModel = SearchModel()
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                GeometryImage(url: album.artwork, showGradient: true, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(album.title)
                                .customLargeNavTitle()
                            Text(album.artistName)
                                .foregroundColor(.white)
                                .font(.callout.weight(.semibold))
                            Text(album.unwrappedReleaseDate)
                                .font(.subheadline.smallCaps())
                                .foregroundColor(.white)
                        }
                        .multilineTextAlignment(.leading)
                        Spacer()
                        Button {
                                playAlbumAndSaveRecent(album)
                        } label: {
                            Image(systemName: "play.fill")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.brandPink)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    Spacer()
                        .frame(height: 75)
                    if !searchModel.songs.isEmpty {
                        Section {
                            ForEach(self.tracks.sorted(by: {$0.trackNumber! < $1.trackNumber!})) { song in
                                FetchedSongFromAlbum(item: song, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                            }
                        } header: {
                            HStack {
                                Text("Songs")
                                     .font(.title2.weight(.semibold))
                                     .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    if !self.relatedAlbums.isEmpty {
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Spacer()
                                    ForEach(self.relatedAlbums) { album in
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
                                Text("Related Albums")
                                     .font(.title2.weight(.semibold))
                                     .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    Spacer()
                        .frame(height: 75)
                }
            }
            CustomNavigationBar(title: album.title, dismiss: dismiss, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
        }
        .navigationBarHidden(true)
        .onAppear {
            if searchModel.songs.isEmpty {
                Task {
                    await searchModel.searchForSong(term: album.title)
                }
            }
            if self.tracks.isEmpty {
                Task {
                    self.tracks = await album.albumTracks()
                }
            }
            if self.relatedAlbums.isEmpty {
                Task {
                    self.relatedAlbums = await album.relatedAlbums()
                }
            }
        }
    }
    private func playAlbumAndSaveRecent(_ album: AlbumItem) {
        Task {
            await nowPlayingModel.playAlbumFromBeginning(album)
            musicModel.savedRecentlyListenedAlbums.append(album)
            musicModel.savedRecentlyListenedAlbums = musicModel.savedRecentlyListenedAlbums
        }
    }
}
