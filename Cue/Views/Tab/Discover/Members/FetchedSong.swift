//
//  FetchedSong.swift
//  Cue
//
//  Created by Jaylen Smith on 10/12/22.
//

import Foundation
import SwiftUI
import MusicKit

struct FetchedSongItem: View {
    
    let item: SongItem
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: item.imageURL) { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                } placeholder: {
                    ProgressView()
                        .frame(width: 50, height: 50)
                        .clipped()
                        .cornerRadius(5)
                        .progressViewStyle(.circular)
                }

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
                NavigationLink {
                    SelectedSongView(song: item, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
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

