//
//  NowPlayingView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/9/22.
//

import SwiftUI

struct NowPlayingView: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    @ObservedObject var favoritesModel: FavoritesModel
    
    var body: some View {
        NavigationView {
            ZStack {
                QueuedSongItemView(musicModel: musicModel, nowPlayingModel: nowPlayingModel )
            }
        }
    }
    
    struct QueuedSongItemView: View {
        
        @ObservedObject var musicModel: MusicModel
        @ObservedObject var nowPlayingModel: NowPlayingModel
        
        var body: some View {
            NowPlayingBackground(nowPlayingModel: nowPlayingModel)
                VStack {
                    NowPlayingDetails(musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                    VStack {
                        Spacer()
                            .frame(height: 100)
                        NowPlayingControls(nowPlayingModel: nowPlayingModel)
                        Spacer()
                    }
                }
        }
        struct NowPlayingBackground: View {
            
            @ObservedObject var nowPlayingModel: NowPlayingModel
            
            var body: some View {
                VStack {
                    Image(uiImage: nowPlayingModel.artwork)
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                        .blur(radius: 95)
                }
                Spacer()
            }
        }
    }
}
    
struct NowPlayingDetails: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            Image(uiImage: nowPlayingModel.artwork)
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250)
                .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(nowPlayingModel.currentSongTitle)
                    .font(.title)
                    .fontWeight(.semibold)
                Text(nowPlayingModel.currentSongArtist)
            }
            .padding()
            Spacer()
        }
    }
}
    
struct NowPlayingControls: View {
    
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "backward.fill")
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "play.fill")
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
            }
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .frame(width: 225)
    }
}

struct NowPlayingView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingView(musicModel: MusicModel(), nowPlayingModel: NowPlayingModel(), favoritesModel: FavoritesModel())
    }
}
