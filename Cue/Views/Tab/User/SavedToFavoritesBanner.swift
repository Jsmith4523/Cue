//
//  SavedToFavoritesBanner.swift
//  Cue
//
//  Created by Jaylen Smith on 10/27/22.
//

import SwiftUI

struct SavedToFavoritesBanner: View {
    
    let image: UIImage
    let title: String
    
    @State private var disapper = false
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottomTrailing) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .cornerRadius(5)
            }
            Image(systemName: "heart.fill")
                .foregroundColor(.brandPink)
        }
        .padding(5)
        .background(Color(uiColor: .systemGray6)
            .cornerRadius(10)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.brandPink)
            })
        )
        .offset(y: disapper ? .infinity : CGFloat())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.linear) {
                    disapper = true
                }
            }
        }
    }
}

struct SavedToFavoritesBanner_Previews: PreviewProvider {
    static var previews: some View {
        SavedToFavoritesBanner(image: UIImage(named: "tyler")!, title: "Flower Boy")
            .preferredColorScheme(.light)
    }
}
