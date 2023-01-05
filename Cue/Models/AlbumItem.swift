//
//  AlbumItem.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import Foundation
import MusicKit

struct AlbumItem: MusicItem, Identifiable, Comparable, Codable {
    var uuid = UUID()
    var id: MusicItemID
    
    let title: String
    let artistName: String
    let releaseDate: Date?
    let reference: Album
    let artwork: URL?
    let artistURL: URL?
    let trackCount: Int
    let url: URL?
    
    let artists: MusicItemCollection<MusicKit.Artist>?
    let tracks: MusicItemCollection<Track>?
    
    let relatedAlbums: MusicItemCollection<MusicKit.Album>?
        
    var unwrappedArtists: [ArtistItem] {
        var arr = [ArtistItem]()
        
        guard let artists = artists else {
            return []
        }
        arr = artists.compactMap { artist in
            return .init(id: artist.id,
                         name: artist.name,
                         artwork: artist.artwork?.url(width: 400, height: 400),
                         url: artist.url,
                         genres: artist.genres,
                         topSongs: artist.topSongs,
                         featuredAlbums: artist.featuredAlbums,
                         fullAlbums: artist.fullAlbums)
        }
        return arr
    }
    
    var unwrappedReleaseDate: String {
        guard let date = releaseDate else {
            return ""
        }
        return date.long()
    }
    
    var unwrappedRelatedAlbums: [AlbumItem] {
        var arr = [AlbumItem]()
        
        guard let albums = relatedAlbums else {
            print("There are no related Albums!")
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
        print(arr)
        return arr
    }
    
    ///Use this method to get songs in a album; not 'tracks' member
    func albumTracks() async -> [SongItem]  {
        
        var arr = [SongItem]()
        
        do {
            let album = try await self.reference.with([.tracks])
            
            print(album.tracks?.count ?? 0)
            
            if let tracks = album.tracks {
                print(tracks.count)
                arr = tracks.compactMap({ track in
                    return .init(id: track.id,
                                 title: track.title,
                                 duration: track.duration,
                                 artist: track.artistName,
                                 artistURL: track.artistURL,
                                 imageURL: track.artwork?.url(width: 300, height: 300),
                                 releaseDate: track.releaseDate,
                                 trackNumber: track.trackNumber,
                                 albumTitle: track.albumTitle,
                                 albums: track.albums)
                })
            }
        } catch {
            print(error.localizedDescription)
        }
        return arr
    }
    
    ///Use this method to get related albums; not 'relatedAlbums' member
    func relatedAlbums() async -> [AlbumItem] {
        var arr = [AlbumItem]()
        
        do {
            let album = try await reference.with([.relatedAlbums])
            
            if let albums = album.relatedAlbums {
                arr = albums.compactMap({ album in
                    return .init(id: album.id,
                                 title: album.title,
                                 artistName: album.artistName,
                                 releaseDate: album.releaseDate,
                                 reference: album,
                                 artwork: album.artwork?.url(width: 300, height: 300),
                                 artistURL: album.artistURL,
                                 trackCount: album.trackCount,
                                 url: album.url,
                                 artists: album.artists,
                                 tracks: album.tracks,
                                 relatedAlbums: album.relatedAlbums
                    )
                })
            }
        } catch {
            print(error.localizedDescription)
        }
        print(arr)
        return arr
    }
    
    static func < (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        lhs.title < rhs.title
    }
    
    static func > (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        lhs.title > rhs.title
    }
    
    static func == (lhs: AlbumItem, rhs: AlbumItem) -> Bool {
        return false
    }
}
