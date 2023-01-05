//
//  SearchViewModel.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import Foundation
import MusicKit
import MediaPlayer


///This model is responsible for fetching song, albums, artists related to a genre
class SearchModel: ObservableObject {
    
    @Published var songs = [SongItem]()
    @Published var albums = [AlbumItem]()
    @Published var artists = [ArtistItem]()
    
    @Published var isShowingDeniedAccessView: Bool = false
    
    ///Search for songs within term
    func searchForSong(term: String) async {
        var request = MusicCatalogSearchRequest(term: term, types: [Song.self])
        request.limit = 25
        
        do {
            let items = try await request.response()
            DispatchQueue.main.async {
                self.songs = items.songs.compactMap({ song in
                    if self.songs.contains(where: {$0.id == song.id}) {
                        print("We already have \(song.title) in the collection")
                        return nil
                    } else {
                        return .init(id: song.id,
                                     title: song.title,
                                     duration: song.duration,
                                     artist: song.artistName,
                                     artistURL: song.artistURL,
                                     imageURL: song.artwork?.url(width: 400, height: 400),
                                     releaseDate: song.releaseDate,
                                     trackNumber: song.trackNumber,
                                     albumTitle: song.albumTitle,
                                     albums: song.albums
                        )
                    }
                })
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    ///Fetch data related to an artist; types songs and albums. Do not use in views related to a genre
    func searchByArtist(artist: String) async {
        var request = MusicCatalogSearchRequest(term: artist, types: [MusicKit.Song.self, MusicKit.Album.self])
        
        for type in request.types {
            request.limit = 25
            if type == MusicKit.Song.self {
                do {
                    let songItems = try await request.response()
                    self.songs = songItems.songs.compactMap({ song in
                        if self.songs.contains(where: {$0.id == song.id}) {
                            print("We already have \(song.title) in the collection")
                            return nil
                        } else {
                            return .init(id: song.id,
                                         title: song.title,
                                         duration: song.duration,
                                         artist: song.artistName,
                                         artistURL: song.artistURL,
                                         imageURL: song.artwork?.url(width: 400, height: 400),
                                         releaseDate: song.releaseDate,
                                         trackNumber: song.trackNumber,
                                         albumTitle: song.albumTitle,
                                         albums: song.albums
                            )
                        }
                    })
                }
                catch {
                    print("There was an error getting that Song for popular artist \(artist)!")
                }
            }
            if type == MusicKit.Album.self {
                request.limit = 10
                do {
                    let albumItems = try await request.response()
                    self.albums = albumItems.albums.compactMap({ album in
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
                                     relatedAlbums: album.relatedAlbums
                        )
                    })
                }
                catch {
                    print("There was an error getting that Album for popular artist \(artist)!")
                }
            }
        }
    }
    
    ///Search for albums within term
    func searchForAlbum(term: String) async {
        var request = MusicCatalogSearchRequest(term: term, types: [MusicKit.Album.self])
        request.limit = 10
                
        do {
            let items = try await request.response()
            DispatchQueue.main.async {
                self.albums = items.albums.compactMap({ album in
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
                                 relatedAlbums: album.relatedAlbums
                    )
                })
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    ///For currently playing song; returns a songItem
    func searchingForSongCurrentlyPlaying(item: MPMediaItem) async -> SongItem? {
        
        guard let title = item.title else {
            return nil
        }
        
        var request = MusicCatalogSearchRequest(term: title, types: [Song.self])
        request.limit = 1
        
        var song: SongItem?
        
        do {
            let items = try await request.response()
            let fetchedSong = items.songs[0]
            
            song = .init(id: fetchedSong.id,
                         title: fetchedSong.title,
                         duration: fetchedSong.duration,
                         artist: fetchedSong.artistName,
                         artistURL: fetchedSong.artistURL,
                         imageURL: fetchedSong.artwork?.url(width: 300, height: 300),
                         releaseDate: fetchedSong.releaseDate,
                         trackNumber: fetchedSong.trackNumber,
                         albumTitle: fetchedSong.albumTitle,
                         albums: fetchedSong.albums)
        } catch {
            print(error.localizedDescription)
        }
        
        guard let songItem = song else {
            return nil
        }
        
        return songItem
    }
    
    func searchForArtist(term: String) async {
        var request = MusicCatalogSearchRequest(term: term, types: [MusicKit.Artist.self])
        request.limit = 20
        
        do {
            let items = try await request.response()
            DispatchQueue.main.async {
                self.artists = items.artists.compactMap({ artist in
                    return .init(id: artist.id,
                                 name: artist.name,
                                 artwork: artist.artwork?.url(width: 300, height: 300),
                                 url: artist.url,
                                 genres: artist.genres,
                                 topSongs: artist.topSongs,
                                 featuredAlbums: artist.featuredAlbums,
                                 fullAlbums: artist.fullAlbums)
                })
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
