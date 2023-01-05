//
//  BeginCueView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI

struct BeginCueView: View {
    
    @ObservedObject var onBoardVM: OnBoardViewModel
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 15) {
                    Spacer()
                        .frame(height: 10)
                    Text("Have Fun!")
                        .largeTitleStyle()
                    Text("We welcome you to Cue and hope you have fun using our product! Enjoy")
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button {
                        onBoardVM.finishedOnBoarding()
                    } label: {
                        Text("Jump In")
                            .onBoardButtonStyle()
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct BeginCueView_Previews: PreviewProvider {
    static var previews: some View {
        BeginCueView(onBoardVM: OnBoardViewModel(), musicModel: MusicModel())
    }
}
