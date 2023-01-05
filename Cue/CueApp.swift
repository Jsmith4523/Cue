//
//  CueApp.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import SwiftUI
import MusicKit
import AVKit

@main
struct CueApp: App {
    
    @StateObject private var onBoardVM = OnBoardViewModel()
    @StateObject private var musicModel = MusicModel()
    @StateObject private var nowPlayingModel = NowPlayingModel()
    @StateObject private var favoritesModel = FavoritesModel()
    
    @Environment (\.scenePhase) var schenePhase
    
    init() {
        let tabBarAppeareance = UITabBarAppearance()
        tabBarAppeareance.shadowColor = .black
        tabBarAppeareance.backgroundColor = .black
        UITabBar.appearance().standardAppearance = tabBarAppeareance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppeareance
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .black
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(musicModel: musicModel, nowPlayingModel: nowPlayingModel, favoritesModel: favoritesModel)
                .gesture(DragGesture()
                    .onChanged({ val in
                        print(val)
                    })
                )
                .sheet(isPresented: $musicModel.isShowingMusicInterestView, content: {
                    NavigationView {
                        MusicInterestView(musicModel: musicModel)
                            .toolbar(content: {
                                Button {
                                    musicModel.isShowingMusicInterestView.toggle()
                                } label: {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.brandPink)
                                }
                            })
                    }
                })
                .sheet(isPresented: $onBoardVM.isShowingOnBoardView) {
                    WelcomeView(onBoardVM: onBoardVM, musicModel: musicModel)
                        .interactiveDismissDisabled()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                        .accentColor(.brandPink)
                }
                .sheet(isPresented: $musicModel.isShowingMusicInterestView, content: {
                    MusicInterestView(musicModel: musicModel)
                })
                .sheet(isPresented: $nowPlayingModel.isShowingNowPlayingView, content: {
                    NowPlayingView(musicModel: musicModel, nowPlayingModel: nowPlayingModel, favoritesModel: favoritesModel)
                })
                .sheet(isPresented: $musicModel.isShowingGenreArrangeView, content: {
                    RearrangeGenreView(musicModel: musicModel)
                })
                .fullScreenCover(isPresented: $musicModel.isShowingDeniedAccessView, content: {
                    PermissionDeniedView(onBoardVM: onBoardVM, musicModel: musicModel)
                        .interactiveDismissDisabled()
                })
                .fullScreenCover(isPresented: $musicModel.isShowingMusicPermissionView, content: {
                    MusicPermissionView(onBoardVM: onBoardVM, musicModel: musicModel)
                        .interactiveDismissDisabled()
                })
                .alert("Whoops, broken record!", isPresented: $nowPlayingModel.alerOfErrorPlayingRequest, actions: {
                    Button("OK") {}
                }, message: {
                    Text("We had a problem playing that request")
                })
                
                .onAppear {
                    onBoardVM.checkOnBoardStatus()
                    musicModel.checkAppleMusicAcess()
                }
                .onChange(of: schenePhase, perform: { phase in
                    switch phase {
                    case .active:
                        Task {
                            await nowPlayingModel.fetchNowPlayingSong()
                        }
                    default:
                        break
                    }
                })
                .onChange(of: ApplicationMusicPlayer.shared.queue.currentEntry) { _ in
                    print("Converting...")
                    Task {
                        await nowPlayingModel.fetchNowPlayingSong()
                    }
                }
        }
    }
}
