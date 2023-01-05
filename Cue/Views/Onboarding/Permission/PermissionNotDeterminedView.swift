//
//  PermissionNotDeterminedView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import SwiftUI

struct PermissionNotDeterminedView: View {
    
    @ObservedObject var onBoardVM: OnBoardViewModel
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                Image(systemName: "music.quarternote.3")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("We need Permission")
                    .largeTitleStyle()
                Text("Cue needs permission to your Apple Music Library for accessing your music and playlist! As well as allowing others to play along as well")
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    Task {
                        await musicModel.askForAppleMusicPermission()
                    }
                } label: {
                    Text("Give Permission")
                        .onBoardButtonStyle()
                }
                Spacer()
            }
            .padding()
        }
    }
}

//struct PermissionNotDeterminedView_Previews: PreviewProvider {
//    static var previews: some View {
//        PermissionNotDeterminedView()
//    }
//}
