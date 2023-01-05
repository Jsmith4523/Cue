//
//  OnboardingViewModel.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import Foundation
import SwiftUI

///This model represents the onboarding of cue: account creation, Apple Music authorization,
class OnBoardViewModel: ObservableObject {
    
    @Published var index: Int = 0
        
    @Published var isShowingOnBoardView: Bool = false
    
    @AppStorage ("isOnboarded") var isOnboarded: Bool = false
    @AppStorage ("didRecieveMusicPermission") var didRecieveMusicPermission: Bool = false
    
    func checkOnBoardStatus() {
        if !isOnboarded {
            isShowingOnBoardView = true
        }
    }
    
    func finishedOnBoarding() {
        self.isOnboarded = true
        self.isShowingOnBoardView = true
        self.isShowingOnBoardView = false
        print(isShowingOnBoardView)
    }
}
