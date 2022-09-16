import Foundation

final class Music {
    let nameMusic: String
    let nameArtist: String
    let image: String
    let audio: String
    
    init(nameMusic: String, nameArtist: String, image: String, audio: String) {
        self.nameMusic = nameMusic
        self.nameArtist = nameArtist
        self.image = image
        self.audio = audio
    }
}

let miyagi     = Music(nameMusic: "Там ревели горы",
                       nameArtist: "Miyagi & Andy Panda",
                       image: PictureURL.miyagi.getPicture,
                       audio: AudioURL.miyagiAudio.getAudio)
let snoopDoogg = Music(nameMusic: "Wiggle (feat. Snoop Dogg)",
                       nameArtist: "Jason Derulo & Snoop Dogg" ,
                       image: PictureURL.snoopDogg.getPicture,
                       audio: AudioURL.snoopDoggAudio.getAudio)
let nickiMinaj = Music(nameMusic: "Majesty",
                       nameArtist: "Nicki Minaj, Labrinth feat. Eminem ",
                       image: PictureURL.nickiMinaj.getPicture,
                       audio: AudioURL.nickiMinajAudio.getAudio)
