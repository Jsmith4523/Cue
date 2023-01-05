//
//  NowPlayingIsland.swift
//  Cue
//
//  Created by Jaylen Smith on 10/9/22.
//

import SwiftUI

struct NowPlayingIsland: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    @State private var rotationEffect = Angle()
    @State private var displayOptions = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .frame(width: 52.5, height: 52.5)
                Image(uiImage: nowPlayingModel.artwork)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
        }
        .rotationEffect(self.rotationEffect)
        .onChange(of: self.rotationEffect.degrees) { rotation in
            if !(rotation > 360.0) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        self.rotationEffect.degrees += 1.0
                    }
                }
            } else {
                self.rotationEffect.degrees = 0.0
            }
        }
        .padding()
        .onAppear {
            if rotationEffect.degrees == 0.0 {
                rotationEffect.degrees = 0.1
            }
        }
        .onTapGesture {
            nowPlayingModel.isShowingNowPlayingView = true
        }
    }
}

struct NowPlayingIsland_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingIsland(musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
            .preferredColorScheme(.dark)
    }
}
