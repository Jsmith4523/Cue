//
//  ArtistItem.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import Foundation
import MusicKit


///Beyonce!
struct ArtistItem: MusicItem, Identifiable, Comparable, Codable {

    var id: MusicItemID
    
    var name: String
    var artwork: URL?
    var url: URL?
    var genres: MusicItemCollection<Genre>?
    
    var topSongs: MusicItemCollection<Song>?
    var featuredAlbums: MusicItemCollection<MusicKit.Album>?
    var fullAlbums: MusicItemCollection<MusicKit.Album>?
    
    
    func albums() async -> [AlbumItem] {
        
        do {
            let batch = try await featuredAlbums?.nextBatch(limit: 5)
            
        } catch {
            print(error.localizedDescription)
        }
        
        return .init()
        
    }
    
    static func == (lhs: ArtistItem, rhs: ArtistItem) -> Bool {
        return true
    }
    
    static func < (lhs: ArtistItem, rhs: ArtistItem) -> Bool {
        lhs.name < rhs.name
    }
    
    static func > (lhs: ArtistItem, rhs: ArtistItem) -> Bool {
        lhs.name > rhs.name
    }
}
