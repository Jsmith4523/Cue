//
//  FetchedAlbum.swift
//  Cue
//
//  Created by Jaylen Smith on 10/12/22.
//

import Foundation
import SwiftUI
import MusicKit

struct FetchedAlbumItem: View {
    
    let item: AlbumItem
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: item.artwork) { img in
                img
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
                    .progressViewStyle(.circular)
            }
            Text(item.title)
                .font(.system(size: 12.5).weight(.semibold))
                .multilineTextAlignment(.leading)
                .lineLimit(1)
            Text(item.artistName)
                .lineLimit(1)
                .font(.system(size: 10.3))
        }
        .frame(width: 100)
        .foregroundColor(.white)
        .contextMenu(ContextMenu(menuItems: {
            Button {
                playAlbumAndSaveRecent()
            } label: {
                Text("Play")
            }
        }))
    }
    
    private func playAlbumAndSaveRecent() {
        Task {
            await nowPlayingModel.playAlbumFromBeginning(item)
            musicModel.savedRecentlyListenedAlbums.append(item)
            musicModel.savedRecentlyListenedAlbums = musicModel.savedRecentlyListenedAlbums
        }
    }
}
