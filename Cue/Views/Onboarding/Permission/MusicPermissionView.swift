//
//  MusicPermissionView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI
import MusicKit

struct MusicPermissionView: View {
    
    @ObservedObject var onBoardVM: OnBoardViewModel
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        VStack {
            if musicModel.hasAppleMusicAccess() {
                PermissionApprovedNavigateView(onBoardVM: onBoardVM, musicModel: musicModel)
            } else if musicModel.deniedMusicAccess {
                PermissionDeniedView(onBoardVM: onBoardVM, musicModel: musicModel)
            } else {
                PermissionNotDeterminedView(onBoardVM: onBoardVM, musicModel: musicModel)
            }
        }
        .navigationBarHidden(true)
        .interactiveDismissDisabled()
    }
}

struct MusicPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        MusicPermissionView(onBoardVM: OnBoardViewModel(), musicModel: MusicModel())
    }
}
