//
//  Song.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import Foundation
import MusicKit

struct SongItem: MusicItem, Identifiable, Comparable, Codable {
   
    var id: MusicItemID
    
    let title: String
    let duration: TimeInterval?
    let artist: String
    let artistURL: URL?
    let imageURL: URL?
    let releaseDate: Date?
    let trackNumber: Int?
    let albumTitle: String?
    let albums: MusicItemCollection<MusicKit.Album>?
    
    var unwrappedRelatedAlbums: [AlbumItem] {
        var arr = [AlbumItem]()
        
        guard let albums = albums else {
            return []
        }
        arr = albums.compactMap { album in
            return .init(id: album.id,
                         title: album.title,
                         artistName: album.artistName,
                         releaseDate: album.releaseDate,
                         reference: album,
                         artwork: album.artwork?.url(width: 400, height: 400),
                         artistURL: album.artistURL,
                         trackCount: album.trackCount,
                         url: album.url,
                         artists: album.artists,
                         tracks: album.tracks,
                         relatedAlbums: album.relatedAlbums)
        }
        return arr
    }
    
    func artistOfThisSong() async -> [ArtistItem] {
        var artists = [ArtistItem]()
        
        var request = MusicCatalogSearchRequest(term: self.artist, types: [MusicKit.Artist.self])
        request.limit = 1
        
        do {
            let response = try await request.response()
        
            artists = response.artists.compactMap({
                .init(id: $0.id,
                      name: $0.name,
                      artwork: $0.artwork?.url(width: 300, height: 300),
                      url: $0.url,
                      genres: $0.genres,
                      topSongs: $0.topSongs,
                      featuredAlbums: $0.featuredAlbums,
                      fullAlbums: $0.fullAlbums
                )
            })
            
        } catch {
            print(error.localizedDescription)
        }
                
        return artists
    }

    
    static func < (lhs: SongItem, rhs: SongItem) -> Bool {
        lhs.trackNumber! < rhs.trackNumber!
    }
    
    static func > (lhs: SongItem, rhs: SongItem) -> Bool {
        lhs.title > rhs.title
    }
    
    static func == (lhs: SongItem, rhs: SongItem) -> Bool {
        return false
    }
}
