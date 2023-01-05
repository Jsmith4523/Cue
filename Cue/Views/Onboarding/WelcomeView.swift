//
//  WelcomeView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI

struct WelcomeView: View {
    
    @ObservedObject var onBoardVM: OnBoardViewModel
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 15) {
                    Image.cue
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                    Text("Welcome to Cue")
                        .largeTitleStyle()
                    Text("Cue makes carpooling easy - allowing anyone to queue their song in likes our your music library")
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink {
                        MusicPermissionView(onBoardVM: onBoardVM, musicModel: musicModel)
                    } label: {
                        Text("Get Started")
                            .onBoardButtonStyle()
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .accentColor(.brandPink)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(onBoardVM: OnBoardViewModel(), musicModel: MusicModel())
    }
}
