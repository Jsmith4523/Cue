//
//  BeginExploringView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/14/22.
//

import SwiftUI
import MusicKit

struct BeginExploringView: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 15) {
                Spacer()
                    .frame(height: 45)
                Text("Your Favorites are empty")
                    .largeTitleStyle()
                Text("Come back here once you have found and selected your favorite songs")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20))
                Spacer()
                Button {
                    musicModel.index = 1
                } label: {
                    Text("Explore")
                        .onBoardButtonStyle()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct BeginExploringView_Previews: PreviewProvider {
    static var previews: some View {
        BeginExploringView(musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
    }
}
