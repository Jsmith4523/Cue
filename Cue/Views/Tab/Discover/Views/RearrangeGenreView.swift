//
//  RearrangeGenreView.swift
//  Cue
//
//  Created by Jaylen Smith on 10/13/22.
//

import SwiftUI

struct RearrangeGenreView: View {
    
    @State private var rearrangeInterest = [MusicInterest]()
    
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rearrangeInterest) { interest in
                    HStack {
                        Text(interest.title)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
                .onMove(perform: rearrange)
            }
            .background(Color.purple)
            .navigationTitle("Edit Genres")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        save()
                        musicModel.isShowingGenreArrangeView = false
                    } label: {
                        Text("Save")
                    }
                    .disabled(self.rearrangeInterest == musicModel.savedMusicInterest)
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        musicModel.isShowingGenreArrangeView = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = UIColor.green
                UITableViewCell.appearance().backgroundColor = UIColor.green
            }
        }
        .accentColor(.brandPink)
        .onAppear {
            self.rearrangeInterest = musicModel.savedMusicInterest
        }
    }
    
    private func rearrange(indexSet: IndexSet, int: Int) {
        self.rearrangeInterest.move(fromOffsets: indexSet, toOffset: int)
    }
    
    private func save() {
        musicModel.savedMusicInterest = self.rearrangeInterest
    }
}

struct RearrangeGenreView_Previews: PreviewProvider {
    static var previews: some View {
        RearrangeGenreView(musicModel: MusicModel())
    }
}
