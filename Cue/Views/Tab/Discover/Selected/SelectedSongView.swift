//
//  SelectedSongView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/9/22.
//

import SwiftUI
import MusicKit

struct SelectedSongView: View {
    
    let song: SongItem
    
    @State private var displayBlack: Bool = false
    @State private var displayInlineTitle: Bool = false
    
    @State private var artistsOfThisSong = [ArtistItem]()
        
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    @StateObject var searchModel = SearchModel()

    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(showsIndicators: false) {
                VStack {
                    GeometryImage(url: song.imageURL, showGradient: true, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(song.title)
                                .customLargeNavTitle()
                            Text(song.albumTitle ?? "")
                                .font(.callout)
                                .foregroundColor(.white)
                            if !artistsOfThisSong.isEmpty {
                                NavigationLink {
                                    SelectedArtistView(artist: self.artistsOfThisSong[0], musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
                                } label: {
                                    Label {
                                        Text(song.artist)
                                            .foregroundColor(.white)
                                            .font(.caption.weight(.semibold))
                                    } icon: {
                                        Image(systemName: "music.mic")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 25)
                    FetchedSongFromAlbum(item: song, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        .onTapGesture {
                            Task {
                                await nowPlayingModel.playSong(song)
                                musicModel.savedRecentlyListenedSongs.append(song)
                            }
                        }
                    Spacer()
                        .frame(height: 75)
                    if !searchModel.albums.isEmpty {
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
                                    Spacer()
                                }
                            }
                        } header: {
                            Text("Suggestions")
                                .navigationHeaderStyle()
                                .padding()
                        }
                    }
                    Spacer()
                        .frame(height: 25)
                    if !song.unwrappedRelatedAlbums.isEmpty {
                        Section {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    Spacer()
                                    ForEach(song.unwrappedRelatedAlbums, id: \.id) { album in
                                        FetchedAlbumItem(item: album, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                                    }
                                    Spacer()
                                }
                            }
                        } header: {
                            Text("Related Albums")
                                .navigationHeaderStyle()
                                .padding()
                        }
                    }
                }
                Spacer()
                    .frame(height: 100)
            }
            CustomNavigationBar(title: song.title, dismiss: dismiss, displayBlack: $displayBlack, displayInlineTitle: $displayInlineTitle)
                .navigationBarHidden(true)
        }.onAppear {
            Task {
                if searchModel.albums.isEmpty {
                    await searchModel.searchForAlbum(term: song.artist)
                }
            }
            Task {
                self.artistsOfThisSong = await song.artistOfThisSong()
            }
        }
    }
}

//struct SelectedSongView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedSongView(musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
//    }
//}
