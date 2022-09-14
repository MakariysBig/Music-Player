import UIKit
import AVFoundation

extension MainViewController {
    final class Views {
        
        //MARK: - Properties
        
        let miyagi = Music(nameMusic: "Там ревели горы",
                           nameArtist: "Miyagi & Andy Panda",
                           currentTime: 0.0,
                           fullTime: 0.0,
                           image: PictureURL.miyagi.getPicture,
                           audio: AudioURL.miyagiAudio.getAudio)
        let snoopDoogg = Music(nameMusic: "Wiggle (feat. Snoop Dogg)",
                               nameArtist: "Jason Derulo & Snoop Dogg" ,
                               currentTime: 0.0,
                               fullTime: 0.0,
                               image: PictureURL.snoopDogg.getPicture,
                               audio: AudioURL.snoopDoggAudio.getAudio)
        let nickiMinaj = Music(nameMusic: "Majesty",
                               nameArtist: "Nicki Minaj, Labrinth feat. Eminem ",
                               currentTime: 0.0,
                               fullTime: 0.0,
                               image: PictureURL.nickiMinaj.getPicture,
                               audio: AudioURL.nickiMinajAudio.getAudio)
        lazy var musicClass = [miyagi, snoopDoogg, nickiMinaj]
        
        let songDescription = UIStackView()
        let songTime = UIStackView()
        let fullTimeOfSong = UILabel()
        let correctTimeOfSong = UILabel()
        let songName = UILabel()
        let artistName = UILabel()
        let playButton = UIButton()
        let forwardButton = UIButton()
        let backwardButton = UIButton()
        let circle = UILabel()
        let slider = UISlider()
        
        var numberOfMusic = 0
        var player: AVAudioPlayer?
        var timer: Timer?
        
        //MARK: - Methods
        
        func loadViews(_ view: UIView) {
            configurePlayer(numberOfMusic: numberOfMusic)
            setUpSongDesctiptionLayout(view, numberOfMusic: numberOfMusic)
            setUpSliderLayout(view)
            setUpCircle(view)
            setUpPlayButtonLayout(view)
            setUpSongTimeLayout(view)
            configureTimer()
            setUpForwardButtonLayout(view)
            setUpBackwardButtonLayout(view)
        }
        
        //MARK: - Private methods
        
        private func configureTimer() {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        }
        
        private func setUpSongTimeLayout(_ view: UIView) {
            view.addSubview(songTime)
            
            songTime.translatesAutoresizingMaskIntoConstraints = false
            songTime.addArrangedSubview(correctTimeOfSong)
            songTime.addArrangedSubview(fullTimeOfSong)
            songTime.axis = .horizontal
            songTime.distribution = .equalCentering
            
            fullTimeOfSong.text = "0:0"
            fullTimeOfSong.textColor = .systemGray
            
            correctTimeOfSong.text = "0:0"
            correctTimeOfSong.textColor = .systemGray
            
            NSLayoutConstraint.activate([
                songTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                songTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                songTime.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            ])
        }
        
        func setUpSongDesctiptionLayout(_ view: UIView, numberOfMusic: Int) {
            view.addSubview(songDescription)
            
            songDescription.axis = .vertical
            songDescription.addArrangedSubview(songName)
            songDescription.addArrangedSubview(artistName)
            songDescription.translatesAutoresizingMaskIntoConstraints = false
            
            songName.text = musicClass[numberOfMusic].nameMusic
            songName.textColor = .white
            songName.font = UIFont.boldSystemFont(ofSize: 25)
            
            artistName.text = musicClass[numberOfMusic].nameArtist
            artistName.textColor = .systemGray
            
            NSLayoutConstraint.activate([
                songDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                songDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                songDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
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
        
        private func setUpCircle(_ view: UIView) {
            view.addSubview(circle)
            circle.backgroundColor = UIColor(red: 34/255, green: 28/255, blue: 42/255, alpha: 1)
            circle.translatesAutoresizingMaskIntoConstraints = false
            circle.layer.cornerRadius = 33
            circle.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                circle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 60),
                circle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                circle.heightAnchor.constraint(equalToConstant: 66),
                circle.widthAnchor.constraint(equalToConstant: 66)
            ])
        }
        
        private func setUpSliderLayout(_ view: UIView) {
            view.addSubview(slider)
            
            guard let player = player else { return }
            
            slider.value = 0.0
            slider.maximumValue = Float(player.duration)
            slider.tintColor = UIColor(red: 130/255, green: 87/255, blue: 231/255, alpha: 1)
            slider.setThumbImage(UIImage(named: "Ellipses"), for: .normal)
            slider.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                slider.heightAnchor.constraint(equalToConstant: 12),
                slider.topAnchor.constraint(equalTo: songDescription.bottomAnchor, constant: 30),
                slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
            slider.addTarget(self, action: #selector(scrubbingSlider), for: .valueChanged)
        }
        
        private func setUpForwardButtonLayout(_ view: UIView) {
            view.addSubview(forwardButton)
            
            forwardButton.setBackgroundImage(UIImage(systemName: "forward.end"), for: .normal)
            forwardButton.tintColor = .white
            forwardButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                forwardButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
                forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 60),
                forwardButton.heightAnchor.constraint(equalToConstant: 28),
                forwardButton.widthAnchor.constraint(equalToConstant: 28),
            ])
        }
        
        private func setUpBackwardButtonLayout(_ view: UIView) {
            view.addSubview(backwardButton)
            
            backwardButton.setBackgroundImage(UIImage(systemName: "backward.end"), for: .normal)
            backwardButton.tintColor = .white
            backwardButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                backwardButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
                backwardButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -60),
                backwardButton.heightAnchor.constraint(equalToConstant: 28),
                backwardButton.widthAnchor.constraint(equalToConstant: 28),
            ])
        }
        
        private func setUpPlayButtonLayout(_ view: UIView) {
            view.addSubview(playButton)
            
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            playButton.tintColor = .white
            playButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                playButton.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
                playButton.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
                playButton.heightAnchor.constraint(equalToConstant: 36),
                playButton.widthAnchor.constraint(equalToConstant: 36),
            ])
        }
        
        func getFormattedTime(timeInterval: TimeInterval) -> String {
            let mins = timeInterval / 60
            let secs = timeInterval.truncatingRemainder(dividingBy: 60)
            
            let timeFormatterForMinutes = NumberFormatter()
            timeFormatterForMinutes.maximumIntegerDigits = 2
            timeFormatterForMinutes.minimumFractionDigits = 0
            timeFormatterForMinutes.roundingMode = .down
            
            let timeFormatterForSeconds = NumberFormatter()
            timeFormatterForSeconds.maximumIntegerDigits = 2
            timeFormatterForSeconds.minimumFractionDigits = 0
            timeFormatterForSeconds.minimumIntegerDigits = 2
            timeFormatterForSeconds.roundingMode = .down
            
            guard let minsStr = timeFormatterForMinutes.string(from: NSNumber(value: mins)),
                  let secsStr = timeFormatterForSeconds.string(from: NSNumber(value: secs)) else {
                      return ""
                  }
            return "\(minsStr):\(secsStr)"
        }
        
        
        //MARK: - Action
        
        @objc func updateSlider() {
            guard let player = player else { return }
            slider.value = Float(player.currentTime)
            slider.maximumValue = Float(player.duration)
            
            let remainingTimeInSconds = player.duration - player.currentTime
            correctTimeOfSong.text = getFormattedTime(timeInterval: player.currentTime)
            fullTimeOfSong.text = getFormattedTime(timeInterval: remainingTimeInSconds)
        }
        
        @objc func scrubbingSlider() {
            guard let player = player else { return }
            player.currentTime = Float64(slider.value)
            player.play()
        }
    }
}
