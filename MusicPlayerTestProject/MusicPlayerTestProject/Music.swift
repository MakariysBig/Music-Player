import Foundation

class Music {
    let nameMusic: String
    let nameArtist: String
    let currentTime: Double
    let fullTime: Double
    let image: String
    let audio: String
    
    init(nameMusic: String, nameArtist: String, currentTime: Double, fullTime: Double, image: String, audio: String) {
        self.nameMusic = nameMusic
        self.nameArtist = nameArtist
        self.currentTime = currentTime
        self.fullTime = fullTime
        self.image = image
        self.audio = audio
    }
}
