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
    private var player: AVAudioPlayer?
    lazy var musicClass = [miyagi, snoopDoogg, nickiMinaj]
    
    var duration: TimeInterval {
        return player?.duration ?? 0
    }
    
    var isPlaying: Bool {
        return player?.isPlaying == true
    }
    
    var currentTime: TimeInterval {
        get {
            player?.currentTime ?? 0
        }
        set {
            player?.currentTime = newValue
        }
    }
    
    var isConfigured: Bool { player != nil }
    
    //MARK: - Methods

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
    
    func play() {
        player?.play()
    }
    
    func stop() {
        player?.stop()
    }
    
    func pause() {
        player?.pause()
    }
}
