//
//  GeometryImageView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/10/22.
//

import Foundation
import SwiftUI
import MusicKit


///Creates a Parallax animation for any image URL passed
struct GeometryImage: View {
    
    let url: URL?
    let showGradient: Bool
    
    @State private var opacity: Double = 1
    
    @Binding var displayBlack: Bool
    @Binding var displayInlineTitle: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.frame(in: .global).minY > 0 ? geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 2.2) : UIScreen.main.bounds.height / 2.2)
                        .opacity(self.opacity)
                        .clipped()
                } placeholder: {
                    Image("black")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.frame(in: .global).minY > 0 ? geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 2.2) : UIScreen.main.bounds.height / 2.2)
                        .opacity(self.opacity)
                        .clipped()
                }
                if showGradient {
                    LinearGradient(colors: [.clear, .black], startPoint: .top, endPoint: .bottom)
                }
            }
            .frame(width: geo.size.width, height: geo.frame(in: .global).minY > 0 ? geo.frame(in: .global).minY + (UIScreen.main.bounds.height / 2.2) : UIScreen.main.bounds.height / 2.2)
            .offset(y: -geo.frame(in: .global).minY)
            .onChange(of: geo.frame(in: .global).minY) { val in
                print(val)
                if val < 0 {
                    withAnimation {
                        opacity = 0
                            displayBlack = true
                        
                    }
                } else if val >= 0 {
                    withAnimation {
                        opacity = 1
                        displayBlack = false
                    }
                }
                else if val < -100 {
                    withAnimation {
                        displayBlack = false
                    }
                }
                if val <= (-UIScreen.main.bounds.height/4)+50 {
                    withAnimation {
                        displayInlineTitle = true
                    }
                } else {
                    withAnimation {
                        displayInlineTitle = false
                    }
                }
            }
        }
        .frame(height: 300)
    }
}
