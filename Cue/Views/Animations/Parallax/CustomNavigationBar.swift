//
//  CustomNavigationBar.swift
//  Cue
//
//  Created by Jaylen Smith on 10/10/22.
//

import Foundation
import MusicKit
import SwiftUI

///Should be paired with GeometryImageView for scrolling
struct CustomNavigationBar: View {
    
    let title: String
    
    @State var dismiss: DismissAction?
    
    @Binding var displayBlack: Bool
    @Binding var displayInlineTitle: Bool
    
    var body: some View {
        ZStack {
            if displayBlack {
                Color.black
                    .edgesIgnoringSafeArea(.top)
            }
            HStack {
                Button {
                    if let dismiss = dismiss {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .padding(8)
                        .background(displayBlack ? .black : .white.opacity(0.70))
                        .clipShape(Circle())
                        .foregroundColor(.brandPink)
                        .font(.system(size: 20))
                }
                if displayInlineTitle {
                    Text(title)
                        .font(.system(size: 22).weight(.semibold))
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
    }
}

struct Previews_CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(title: "Classical", dismiss: nil, displayBlack: .constant(false), displayInlineTitle: .constant(true))
    }
}
