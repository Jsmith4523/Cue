//
//  Settings.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI

struct Settings: View {
    
    @ObservedObject var musicModel: MusicModel
    
    var body: some View {
        NavigationView {
            List {
                Section {
//                    Button {
//                        musicModel.isShowingMusicInterestView = true
//                    } label: {
//                        Text("Reset Favorite Artists")
//                    }
//                    Button {
//                        musicModel.isShowingMusicInterestView = true
//                    } label: {
//                        Text("Reset Favorite Songs")
//                    }
//                    Button {
//                        musicModel.isShowingMusicInterestView = true
//                    } label: {
//                        Text("Reset Favorite Albums")
//                    }
                    Button {
                        musicModel.isShowingMusicInterestView = true
                    } label: {
                        listLabel(symbol: "list.triangle", text: "Music Genres")
                    }
                } header: {
                    Text("Interest")
                }
                
                Section {
                    Toggle("Always Show Now Playing", isOn: $musicModel.showSheetOnSelection)
                } header: {
                    Text("Preferences")
                } footer: {
                    Text("When this option is on, now playing will always appear if an album, song, or artist is selected to be played. \n\nThis will also allow now playing to show when Cue is opened from the background")
                }
            }
            .navigationTitle("Settings")
        }
        .tint(.brandPink)
    }
    
    private func listLabel(symbol: String, text: String) -> some View {
        HStack {
            Image(systemName: symbol)
                .foregroundColor(.brandPink)
            Text(text)
                .foregroundColor(.white)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(musicModel: MusicModel())
    }
}
