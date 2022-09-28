import Foundation
import AVFoundation

final class MusicManager {
    
    //MARK: - Private properties
    
    private let miyagi     = Music(nameMusic: "Там ревели горы",
                                   nameArtist: "Miyagi & Andy Panda",
                                   image: PictureURL.miyagi.getPicture,
                                   audio: AudioURL.miyagiAudio.getAudio)
    private let snoopDoogg = Music(nameMusic: "Wiggle (feat. Snoop Dogg)",
                                   nameArtist: "Jason Derulo & Snoop Dogg" ,
                                   image: PictureURL.snoopDogg.getPicture,
                                   audio: AudioURL.snoopDoggAudio.getAudio)
    private let nickiMinaj = Music(nameMusic: "Majesty",
                                   nameArtist: "Nicki Minaj, Labrinth feat. Eminem ",
                                   image: PictureURL.nickiMinaj.getPicture,
                                   audio: AudioURL.nickiMinajAudio.getAudio)
    
    //MARK: - Properties
    
    var numberOfMusic = 0
    var player: AVAudioPlayer?
    lazy var musicClass = [miyagi, snoopDoogg, nickiMinaj]
    
    //MARK: - Methods
    
    func setUpPlayer() {
        configurePlayer(numberOfMusic: numberOfMusic)
    }

    func configurePlayer(numberOfMusic: Int) {
        let urlString = Bundle.main.path(forResource: musicClass[numberOfMusic].audio, ofType: "mp3")
        guard let urlString = urlString else { return }
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
        } catch {
            print("ViewController-AVAudioSession-failed")
        }
    }
}
