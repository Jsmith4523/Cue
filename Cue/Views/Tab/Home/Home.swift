//
//  Home.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI
import MusicKit

enum pickerSelection: String {
    case forMe = "For Me"
    case fromFriends = "From Friends"
    case favorites = "Favorites"
}

struct Home: View {
    
    private let selections: [pickerSelection] = [.forMe, .fromFriends, .favorites]
    
    @State private var selection: pickerSelection = .forMe
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    ForMeView(musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                    Spacer()
                }
                NowPlayingIsland(musicModel: musicModel, nowPlayingModel: nowPlayingModel)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(self.selection.rawValue)
        }
    }
}

struct ForMeView: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(musicModel.savedMusicInterest.sorted(by: <)) { genre in
                    VStack {
                        GenreCompartment(genre: genre, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct GenreCompartment: View {
    
    let genre: MusicInterest
    
    @StateObject var searchModel = SearchModel()
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Text(genre.title)
                        .font(.title2.weight(.semibold))
                    Spacer()
                    NavigationLink {
                        SelectedGenreView(genre: genre, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.brandPink)
                    }
                }
                Divider()
            }
            .padding(.horizontal)
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(searchModel.albums) { album in
                    FetchedAlbumItem(item: album, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                }
            }
        }
        .task {
            await searchModel.searchForAlbum(term: genre.title)
        }
    }
}

struct FromFriendsView: View {
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack {
            Image(systemName: "person.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Suggestions from friends will show up here. You can also send friends songs, albums, or artists you've recently listened to or have favorited.")
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            Button {
                
            } label: {
                Image(systemName: "paperplane")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
    }
}
