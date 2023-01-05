//
//  MusicViewModel.swift
//  Cue
//
//  Created by Jaylen Smith on 10/9/22.
//

import Foundation
import SwiftUI
import MusicKit


///This model handles 
class MusicModel: ObservableObject {
    
    @Published var index = 0
        
    @Published var alertOfReachedLimit: Bool = false
    
    @Published var isShowingMusicInterestView: Bool = false
    @Published var isShowingSelectedSongView: Bool = false
    @Published var isShowingMusicPermissionView: Bool = false
    @Published var isShowingGenreArrangeView: Bool = false
    @Published var isShowingDeniedAccessView: Bool = false
    
    @Published var deniedMusicAccess = false
    @Published var approvedMusicAccess = false
        
    @AppStorage ("showSheetOnSelection") var showSheetOnSelection = true
        
    let limitOfMusicInterest = 10
    
    @Published var savedMusicInterest = [MusicInterest]() {
        didSet {
            let encoder = JSONEncoder()
            if let enconded = try? encoder.encode(savedMusicInterest) {
                UserDefaults.standard.set(enconded, forKey: "Interests")
            }
            print("Interest saved as recent")
        }
    }
    
    @Published var savedRecentlyListenedSongs = [SongItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let enconded = try? encoder.encode(savedRecentlyListenedSongs) {
                UserDefaults.standard.set(enconded, forKey: "recentlyListenedSongs")
            }
            print("Song saved as recent")
        }
    }
    
    @Published var savedRecentlyListenedAlbums = [AlbumItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let enconded = try? encoder.encode(savedRecentlyListenedAlbums) {
                UserDefaults.standard.set(enconded, forKey: "recentlyListenedAlbums")
            }
            print("Album saved as recent")
        }
    }
    
    @Published var savedRecentlyListenedArtists = [ArtistItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let enconded = try? encoder.encode(savedRecentlyListenedArtists) {
                UserDefaults.standard.set(enconded, forKey: "recentlyListenedArtists")
                print("Artist saved as recent")
            }
        }
    }
    
    init() {
        if let savedInterests = UserDefaults.standard.data(forKey: "Interests") {
            if let interests = try? JSONDecoder().decode([MusicInterest].self, from: savedInterests) {
                self.savedMusicInterest = interests
            }
        } else {
            self.savedMusicInterest = []
        }
        if let listenedSongs = UserDefaults.standard.data(forKey: "recentlyListenedSongs") {
            if let songs = try? JSONDecoder().decode([SongItem].self, from: listenedSongs) {
                self.savedRecentlyListenedSongs = songs
            }
        } else {
            self.savedRecentlyListenedSongs = []
        }
        
        if let listenedAlbums = UserDefaults.standard.data(forKey: "recentlyListenedAlbums") {
            if let albums = try? JSONDecoder().decode([AlbumItem].self, from: listenedAlbums) {
                self.savedRecentlyListenedAlbums = albums
            }
        } else {
            self.savedRecentlyListenedAlbums = []
        }
        
        if let listenedArtists = UserDefaults.standard.data(forKey: "recentlyListenedArtists") {
            if let artists = try? JSONDecoder().decode([ArtistItem].self, from: listenedArtists) {
                self.savedRecentlyListenedArtists = artists
            }
        } else {
            self.savedRecentlyListenedArtists = []
        }
    }
    
    ///Check Music Authorization
    func checkAppleMusicAcess() {
        switch MusicAuthorization.currentStatus {
        case .notDetermined:
            deniedMusicAccess = false
            DispatchQueue.main.async {
                self.isShowingMusicPermissionView = true
            }
            print("")
        case .denied:
            deniedMusicAccess = true
            isShowingDeniedAccessView = true
            print("")
        case .restricted:
            deniedMusicAccess = true
            isShowingMusicPermissionView = true
            print("")
        case .authorized:
            deniedMusicAccess = false
            print("")
        @unknown default:
            isShowingMusicPermissionView = true
        }
        print(MusicAuthorization.currentStatus)
    }
    
    ///Return Bool based of Music Authorization case
    func hasAppleMusicAccess() -> Bool {
        switch MusicAuthorization.currentStatus {
        case .notDetermined:
            return false
        case .denied:
            DispatchQueue.main.async {
                self.deniedMusicAccess = true
            }
            return false
        case .restricted:
            DispatchQueue.main.async {
                self.deniedMusicAccess = true
            }
            return false
        case .authorized:
            return true
        @unknown default:
            return false
        }
    }
    
    func askForAppleMusicPermission() async {
        Task {
            let request = await MusicAuthorization.request()
            switch request {
                
            case .notDetermined:
                print("Not Determined")
            case .denied:
                DispatchQueue.main.async {
                    self.deniedMusicAccess = true
                }
            case .restricted:
                print("Restricted")
            case .authorized:
                DispatchQueue.main.async {
                    self.approvedMusicAccess = true
                }
                print("Authorized")
            @unknown default:
                print("Default")
            }
        }
    }
}

