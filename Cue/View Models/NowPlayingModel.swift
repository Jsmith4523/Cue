//
//  NowPlayingModel.swift
//  Cue
//
//  Created by Jaylen Smith on 10/8/22.
//

import Foundation
import MusicKit
import MediaPlayer
import SwiftUI

enum ShuffleType: String {
    case none = "None"
    case shuffle = "Shuffle"
}

///This mode handles now playing song information and ApplicationMusicPlayer controls
final class NowPlayingModel: ObservableObject {
    
    @Published var isShowingNowPlayingView: Bool = false
    @Published var alerOfErrorPlayingRequest: Bool = false
    
    @Published var currentSongPlaying = [String: Any]()
    
    ///This is just to observe if the current queued song has changed
    var currentEntryID: String {
        print("Got entry")
        return ApplicationMusicPlayer.shared.queue.currentEntry?.title ?? ""
    }
           
    @AppStorage ("userShuffleType") var userShuffleType: ShuffleType = ShuffleType.none
    
    private var player = ApplicationMusicPlayer.shared
    var nowPlaying = MPMusicPlayerController.applicationMusicPlayer
    
    
//    "title": npItem.title!,
//    "artist": npItem.artist!,
//    "albumTitle": npItem.albumTitle!,
//    "artwork": npItem.assetURL!,
//    "duration": npItem.playbackDuration,
//    "lyrics": npItem.lyrics!,
//    "reference": npItem.self
    
    var currentSongTitle: String {
        currentSongPlaying["title"] as? String ?? "Not Playing"
    }
    
    var currentSongArtist: String {
        currentSongPlaying["artist"] as? String ?? ""
    }
    
    var albumTitle: String {
        currentSongPlaying["albumTitle"] as? String ?? ""
    }
    
    var artwork: UIImage {
                
        guard let albumArtwork = currentSongPlaying["artwork"] as? MPMediaItemArtwork else {
            return UIImage()
        }
            
        return albumArtwork.image(at: CGSize(width: 300, height: 300)) ?? UIImage()
    }
    
    var lyrics: String {
        print("Lyrics")
        print(currentSongPlaying["lyrics"] as? String ?? "")
        return currentSongPlaying["lyrics"] as? String ?? ""
    }
    
    var reference: MPMediaItem {
        currentSongPlaying["reference"] as? MPMediaItem ?? .init()
    }
            
    private func wasSuccessfulToQueue() async {
        await UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        if UserDefaults.standard.bool(forKey: "showSheetOnSelection") {
            DispatchQueue.main.async {
                self.isShowingNowPlayingView = true
            }
        }
        
        await fetchNowPlayingSong()
    }
    
    ///Play album matching its MusicID
    func playAlbumFromBeginning(_ album: AlbumItem) async {
        let id = MusicItemID("\(album.id)")
        
        do {
            let request = MusicCatalogResourceRequest<MusicKit.Album>(matching: \.id, equalTo: id)
            let resp = try await request.response()
            
            guard let responseAlbum = resp.items.first else {
                await UINotificationFeedbackGenerator().notificationOccurred(.error)
                DispatchQueue.main.async {
                    self.alerOfErrorPlayingRequest = true
                }
                return
            }
            
            player.queue = [responseAlbum]
            
            try await player.play()
            
            await wasSuccessfulToQueue()
            
        } catch {
            await UINotificationFeedbackGenerator().notificationOccurred(.error)
            DispatchQueue.main.async {
                self.alerOfErrorPlayingRequest = true
            }
            
            print(error.localizedDescription)
        }
    }
    
    ///Play songs  matching its MusicID
    func playSong(_ song: SongItem) async {
        
        let id = MusicItemID("\(song.id)")
        
        do {
            let request = MusicCatalogResourceRequest<MusicKit.Song>(matching: \.id, equalTo: id)
            let resp = try await request.response()
            
            guard let song = resp.items.first else {
                await UINotificationFeedbackGenerator().notificationOccurred(.error)
                self.alerOfErrorPlayingRequest = true
                
                return
            }
            
            player.queue = [song]
            
            try await player.play()
            
            await wasSuccessfulToQueue()
            
        } catch {
            await UINotificationFeedbackGenerator().notificationOccurred(.error)
            DispatchQueue.main.async {
                self.alerOfErrorPlayingRequest = true
            }
            print(error.localizedDescription)
        }
    }
    
    ///Play songs of an Artist matching its MusicID
    func playArtist(_ artist: ArtistItem) async {
        
    }

    ///Resume playback
    func play() async {
        do {
            try await player.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///Pause playback
    func pause() {
        player.pause()
    }
    
    func fetchNowPlayingSong() async {
        guard let npItem = nowPlaying.nowPlayingItem else {
            return
        }
                
        DispatchQueue.main.async {
            self.currentSongPlaying = [
                "title": npItem.title ?? "Untitled Song",
                "artist": npItem.artist ?? "Untitled Artist",
                "albumTitle": npItem.albumTitle ?? "Untitled Album",
                "artwork": npItem.artwork ?? MPMediaItemArtwork.self,
                "duration": npItem.playbackDuration,
                "lyrics": npItem.lyrics ?? "",
                "reference": npItem.self
            ]
            print(self.currentSongTitle)
        }
    }
    
    func previous() async {
        do {
            try await player.skipToPreviousEntry()
        } catch {
            print(error.localizedDescription)
        }
        await self.fetchNowPlayingSong()
    }
    
    func forward() async {
        player.beginSeekingForward()
        await self.fetchNowPlayingSong()
    }
}
