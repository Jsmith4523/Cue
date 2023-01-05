//
//  PermissionDeniedView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI

struct PermissionDeniedView: View {
    
    @ObservedObject var onBoardVM: OnBoardViewModel
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                Image(systemName: "hand.raised.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Permission Denied")
                    .largeTitleStyle()
                Text("Unfortunately, Cue does not have permission to accces your Apple Music Library. Open settings to enable access to your Apple Music service.")
                    .multilineTextAlignment(.center)
                Spacer()
                Button {
                    URL.openCueSettings()
                } label: {
                    Text("Open Settings")
                        .onBoardButtonStyle()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct PermissionDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionDeniedView(onBoardVM: OnBoardViewModel(), musicModel: MusicModel())
    }
}
