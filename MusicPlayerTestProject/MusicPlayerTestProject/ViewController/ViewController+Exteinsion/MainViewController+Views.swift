import UIKit

extension MainViewController {
    final class Views {
        
        //MARK: - Properties
        
        let playButton = UIButton()
        let forwardButton = UIButton()
        let backwardButton = UIButton()
        let fullTimeOfSong = UILabel()
        let correctTimeOfSong = UILabel()
        let songName = UILabel()
        let artistName = UILabel()
        let slider = UISlider()

        //MARK: - Private properties
        
        private let songDescription = UIStackView()
        private let songTime = UIStackView()
        private let circle = UILabel()
        
        //MARK: - Methods
        
        func loadViews(_ view: UIView) {
            setUpSongDesctiptionLayout(view)
            setUpSliderLayout(view)
            setUpCircle(view)
            setUpPlayButtonLayout(view)
            setUpSongTimeLayout(view)
            setUpForwardButtonLayout(view)
            setUpBackwardButtonLayout(view)
        }
        
        func setUpSongDesctiptionLayout(_ view: UIView) {
            view.addSubview(songDescription)
            
            songDescription.axis = .vertical
            songDescription.addArrangedSubview(songName)
            songDescription.addArrangedSubview(artistName)
            songDescription.translatesAutoresizingMaskIntoConstraints = false
            
            songName.textColor = .white
            songName.font = UIFont.boldSystemFont(ofSize: 25)
            
            artistName.textColor = .systemGray
            
            NSLayoutConstraint.activate([
                songDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                songDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                songDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
        }
        
        //MARK: - Private methods
        
        private func setUpSongTimeLayout(_ view: UIView) {
            view.addSubview(songTime)
            
            songTime.translatesAutoresizingMaskIntoConstraints = false
            songTime.addArrangedSubview(correctTimeOfSong)
            songTime.addArrangedSubview(fullTimeOfSong)
            songTime.axis = .horizontal
            songTime.distribution = .equalCentering
            
            fullTimeOfSong.textColor = .systemGray
            correctTimeOfSong.textColor = .systemGray
            
            NSLayoutConstraint.activate([
                songTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                songTime.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                songTime.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            ])
        }
        
        private func setUpCircle(_ view: UIView) {
            view.addSubview(circle)
            
            circle.backgroundColor = .myCircleColor
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
            
            slider.value = 0.0
            slider.tintColor = .mySliderColor
            slider.setThumbImage(UIImage(named: "Ellipses"), for: .normal)
            slider.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                slider.heightAnchor.constraint(equalToConstant: 12),
                slider.topAnchor.constraint(equalTo: songDescription.bottomAnchor, constant: 30),
                slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
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
    }
}
