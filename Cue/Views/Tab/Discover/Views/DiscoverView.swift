//
//  Discover.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI
import MusicKit

struct Discover: View {
    
    @State private var interests = [MusicInterest]()
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(self.interests) { genre in
                        NavigationLink {
                            SelectedGenreView(genre: genre, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        } label: {
                            DiscoverGenreMember(interest: genre, musicModel: musicModel, nowPlayingModel: nowPlayingModel)
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Discover")
            .toolbar {
                ToolbarItemGroup {
                    NavigationLink {
                        UserSearchView(nowPlayingModel: nowPlayingModel, musicModel: musicModel)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.brandPink)
                    }
                    Button {
                        musicModel.isShowingGenreArrangeView = true
                    } label: {
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .foregroundColor(.brandPink)
                    }
                }
            }
        }
        .onAppear {
            if !(interests.count > 0) {
                populateGenres()
            } else if interests != musicModel.savedMusicInterest {
                removeAndPopulate()
            }
        }
        .onChange(of: musicModel.savedMusicInterest) { _ in
            print("Changes were made!")
            populateGenres()
        }
    }

    private func removeAndPopulate() {
        self.interests.removeAll()
        populateGenres()
    }
    
    private func populateGenres() {
        if musicModel.savedMusicInterest.count != 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.interests = musicModel.savedMusicInterest
                }
            }
        }
    }
}

struct DiscoverGenreMember: View {
    
    let interest: MusicInterest
    
    @State private var artworkImage: Image?
    
    @ObservedObject var musicModel: MusicModel
    @ObservedObject var nowPlayingModel: NowPlayingModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: interest.imageURL) { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/2.3, height: 175)
                        .onAppear {
                           artworkImage = img
                        }
                } placeholder: {
                    Image("placeholder-artwork")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width/2.3, height: 175)
                }
                LinearGradient(colors: [.clear, .black.opacity(0.65)], startPoint: .top, endPoint: .bottom)
                HStack {
                    Text(interest.title)
                        .font(.callout.bold())
                        .foregroundColor(.white)
                }
                .padding()
            }
            .cornerRadius(15)
        }
    }
}


struct Previews_DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverGenreMember(interest: .init(title: "Hip-Hop", imageURL: URL(string: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fhip-hop&psig=AOvVaw1dowhzXTGN7GEbnwvx5HaR&ust=1666913494253000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIDekeeG__oCFQAAAAAdAAAAABAE")), musicModel: MusicModel(), nowPlayingModel: NowPlayingModel())
    }
}

