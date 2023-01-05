//
//  View+EXT.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import Foundation
import SwiftUI

extension View {
    
    func onBoardButtonStyle() -> some View {
        return self
            .font(.body.weight(.semibold))
            .modifier(OnBoardButtonStyle())
    }
    
    func largeTitleStyle() -> some View {
        return self
            .font(.largeTitle.smallCaps())
    }
    
    func customLargeNavTitle() -> some View {
        return self
            .font(.title.weight(.semibold))
    }
    
    //LIKE THIS
    func headerStyle() -> some View{
        return self
            .font(.title2.smallCaps().bold())
    }
    
    ///"This,  but not capitalized"
    func navigationHeaderStyle() -> some View {
        return self
        .font(.title2.weight(.semibold))
        .foregroundColor(.white)
    }
    
    func albumArtHeaderButtonStyle() -> some View {
        return self
            .padding(10)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
    }
}

struct OnBoardButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: UIScreen.main.bounds.width-100)
            .foregroundColor(.white)
            .background(Color.brandPink)
            .cornerRadius(10)
    }
}
