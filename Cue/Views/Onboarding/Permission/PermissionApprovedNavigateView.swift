//
//  PermissionApprovedView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import SwiftUI

struct PermissionApprovedNavigateView: View {
    
    @ObservedObject var onBoardVM: OnBoardViewModel
    @ObservedObject var musicModel: MusicModel
    
    @Environment (\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                Image(systemName: "checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.green)
                Text("Permission Granted")
                    .largeTitleStyle()
                Text("Congrats! Cue now has access to your Apple Music Library.")
                    .multilineTextAlignment(.center)
                Spacer()
                
                if onBoardVM.isOnboarded {
                    Button("Great!") {
                        dismiss()
                    }
                    .onBoardButtonStyle()
                } else {
                    NavigationLink( destination: {
                        MusicInterestView(onBoardVM: onBoardVM, musicModel: musicModel)
                    }, label: {
                        Text("Next")
                            .onBoardButtonStyle()
                    })
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct PermissionApprovedView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionApprovedNavigateView(onBoardVM: OnBoardViewModel(), musicModel: MusicModel())
    }
}
