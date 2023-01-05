//
//  MusicInterest.swift
//  Cue
//
//  Created by Jaylen Smith on 10/11/22.
//

import Foundation
import MusicKit

struct MusicInterest: Identifiable, Hashable, Comparable, Codable {
    
    var id = UUID()
    let title: String
    let imageURL: URL?
    
    static func > (lhs: MusicInterest, rhs: MusicInterest) -> Bool {
        return lhs.title > rhs.title
    }
    
    static func < (lhs: MusicInterest, rhs: MusicInterest) -> Bool {
        return lhs.title < rhs.title
    }
}

let musicInterests: [MusicInterest] = [
    MusicInterest(title: "Hip-Hop",
                  imageURL: URL(string: "https://s26162.pcdn.co/wp-content/uploads/2019/03/shabazz-hiphop_1024.jpg")),
    MusicInterest(title: "R&B",
                  imageURL: URL(string: "https://www.masterclass.com/cdn-cgi/image/width=1920,quality=75,format=webp/https://images.ctfassets.net/3s5io6mnxfqz/1FcEQxYltPqr3yQwm5xDPH/4dc9f2e40d1b05bad20d466958a5f260/AdobeStock_255890026.jpeg")),
    MusicInterest(title: "Country",
                  imageURL: URL(string: "https://www.musicianwave.com/wp-content/uploads/2021/12/Why-People-Hate-Country-Music-2048x1364.jpg")),
    MusicInterest(title: "Pop",
                  imageURL: URL(string: "https://assets.deutschlandfunk.de/FILE_a20b6674d3e9a7b9f4c65a60f17987c3/1280x720.jpg?t=1597591673933")),
    MusicInterest(title: "Metal",
                  imageURL: URL(string: "https://images.saymedia-content.com/.image/c_limit%2Ccs_srgb%2Cq_auto:eco%2Cw_1400/MTc0NDkxNzA3MjAxODg5NjQw/100-best-rock-songs-of-the-90s.webp")),
    MusicInterest(title: "Comedy",
                  imageURL: URL(string: "https://www.rd.com/wp-content/uploads/2018/07/13-Things-a-Stand-Up-Comedian-Wont-Tell-You-10.jpg?resize=700,466")),
    MusicInterest(title: "Mexican",
                  imageURL: URL(string: "https://www.musicianwave.com/wp-content/uploads/2022/08/Types-of-Mexican-Music-788x525.jpg")),
    MusicInterest(title: "Dance",
                  imageURL: URL(string: "https://media.istockphoto.com/photos/rock-concert-picture-id627682404?k=20&m=627682404&s=612x612&w=0&h=9bsVL8AxH759EsZcR2Qd0k3Qhfnq0Q8cNumMyvmRz2U=")),
    MusicInterest(title: "Electronic",
                  imageURL: URL(string: "https://spillmagazine.com/wp-content/uploads/2018/06/Electronic-Music.jpg")),
    MusicInterest(title: "Party",
                  imageURL: URL(string: "https://images.unsplash.com/photo-1524368535928-5b5e00ddc76b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bXVzaWMlMjBwYXJ0eXxlbnwwfHwwfHw%3D&w=1000&q=80")),
    MusicInterest(title: "Instrumental",
                  imageURL: URL(string: "https://media.istockphoto.com/photos/acoustic-guitar-on-the-background-of-a-recording-studio-room-for-picture-id1224225082?b=1&k=20&m=1224225082&s=170667a&w=0&h=UA5KUixkjsIBg3zr3CBlZETheWjyBAgQfT2uf5xN1cg=")),
    MusicInterest(title: "Gospel",
                  imageURL: URL(string: "https://www.udiscovermusic.com/wp-content/uploads/2019/04/Mahalia-Jackson-GettyImages-74276273.jpg")),
    MusicInterest(title: "Rock",
                  imageURL: URL(string: "https://townsquare.media/site/366/files/2022/02/attachment-slash-20202.jpg")),
    MusicInterest(title: "Jazz",
                  imageURL: URL(string: "https://www.incimages.com/uploaded_files/image/1920x1080/getty_530406235_409211.jpg")),
    MusicInterest(title: "Classical",
                  imageURL: URL(string: "https://img.apmcdn.org/c75e4ad850e43237fe0568a59ab71b15cb2511ac/uncropped/b80d45-20120627-flute-concert.jpg"))
]
