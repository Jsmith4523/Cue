//
//  FetchedSongFromAlbum.swift
//  Cue
//
//  Created by Jaylen Smith on 11/7/22.
//

import SwiftUI
import MusicKit

struct FetchedSongFromAlbum: View {
    
    let item: SongItem
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .lineLimit(2)
                        .font(.callout.weight(.semibold))
                        .multilineTextAlignment(.leading)
                    Text(item.artist)
                        .lineLimit(1)
                        .font(.caption)
                }
                .foregroundColor(.white)
                Spacer()
            }
            Divider()
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .contextMenu(ContextMenu(menuItems: {
            Button {
                playSongAndSaveRecent(item)
            } label: {
                Text("Play")
            }
            Button {
                
            } label: {
                Text("Favorite")
            }
        }))
    }
    
    private func playSongAndSaveRecent(_ song: SongItem) {
        Task {
            await nowPlayingModel.playSong(song)
            musicModel.savedRecentlyListenedSongs.append(song)
            musicModel.savedRecentlyListenedSongs = musicModel.savedRecentlyListenedSongs
        }
    }
}

struct FetchedSongFromAlbum_Previews: PreviewProvider {
    static var previews: some View {
        FetchedSongFromAlbum(item: SongItem(id: .init(""), title: "", duration: .infinity, artist: "", artistURL: nil, imageURL: nil, releaseDate: nil, trackNumber: nil, albumTitle: nil, albums: nil), musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
    }
}
