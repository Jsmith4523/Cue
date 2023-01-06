# Cue
I created "Cue" because I wanted to solve a problem regarding listening to music with friends in car. Apple CarPlay is an innovative way to interact with your
vehicles infotainment. But the problem comes with passengers requesting to queue a song whilst the driver is driving. CarPlay is often not very helping for searching for offline. 
And the driver -- if not accompanied by a passenger -- is distracted if they're attempting to use their phone to search for their passengers song.
Cue is meant to solve that: by including NFC readers within the vehicle, riders can queue thier song to the drivers queue list without the need of distractions or using their device while driving. 

***What I learned***
- Introduction to MusicKit, MusicItem, MusicItemCollection, MusicCatalogSearchRequest, ApplicationMediaPlayer, MPMusicPlayerController, async/await methods.
- Further practice with proper Navigation within an application. 
- Fetching songs from Apple Music and queuing them within the Application's media player
- Saving and retrieving a users "music interest" using UserDefaults, JSONDecoder and JSONEncoder

In some areas of creating the application came issues I've ran into during development:

***Issues***
- Although MusicKit recieves songs from Apple Music based of a request, requesting to play most songs is not allowed
- When fetching for albums, they do not automatically include their tracks (songs). This causing more code within the 'AlbumItem' object for getting the 
reference of those tracks.
- As challenging it is retrieivng an albums tracks, it is also challenging retreiving related or suggested albums or artist of the selected Album.
- MusicKit (from what I've tested) does not retrieve actual genre of artists at times. Searching for "Pop" will show most popular "Pop" artist, 
but will also artists named "Pop."
- MusicKit unfortunately does not allow you to debug within a simulator. This causes for issues when considering layouts smaller devices. 
