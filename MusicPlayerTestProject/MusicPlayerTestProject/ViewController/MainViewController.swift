import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - Private properties
    
    private let views = Views()
    private let layout = UICollectionViewFlowLayout()
    private let musicManager = MusicManager()
    private var index = 0
    private var timer: Timer?
    
    //MARK: - Override properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBackgroundColor
        configureSongDesctiption()
        views.loadViews(view)
        setUpTarget()
        setUpCollectionViewLayout()
        musicManager.setUpPlayer()
        setUpMaximumValueForSlider()
        configureTimer()
    }
    
    //MARK: - Private methods
    
    private func configureSongDesctiption() {
        views.songName.text = musicManager.musicClass[musicManager.numberOfMusic].nameMusic
        views.artistName.text = musicManager.musicClass[musicManager.numberOfMusic].nameArtist
    }
    
    private func setUpTarget() {
        views.forwardButton.addTarget(self, action: #selector(tapNextSongAction), for: .touchUpInside)
        views.backwardButton.addTarget(self, action: #selector(tapPreviousSongAction), for: .touchUpInside)
        views.playButton.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
        views.slider.addTarget(self, action: #selector(scrubbingSlider), for: .valueChanged)
    }
    
    private func setUpMaximumValueForSlider() {
        guard let player = musicManager.player else { return }
        
        views.slider.maximumValue = Float(player.duration)
    }
    
    private func setUpCollectionViewLayout() {
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset.left = 40
        layout.sectionInset.right = 80

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33)
        ])
    }
    
    private func configureTrack() {
        let indexPath = IndexPath(row: index, section: 0)
        layout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        musicManager.configurePlayer(numberOfMusic: musicManager.numberOfMusic)
        configureSongDesctiption()

        guard let player = musicManager.player else { return }
        
        if views.playButton.isSelected {
            player.play()
        } else {
            player.stop()
        }
    }
    
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
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
    
    private func configureTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    //MARK: - Action
    
    @objc private func scrubbingSlider() {
        guard let player = musicManager.player else { return }
        player.currentTime = Float64(views.slider.value)
        player.play()
    }
    
    @objc private func updateSlider() {
        guard let player = musicManager.player else { return }
        views.slider.value = Float(player.currentTime)
        views.slider.maximumValue = Float(player.duration)
        
        let remainingTimeInSconds = player.duration - player.currentTime
        views.correctTimeOfSong.text = getFormattedTime(timeInterval: player.currentTime)
        views.fullTimeOfSong.text = getFormattedTime(timeInterval: remainingTimeInSconds)
    }
    
    @objc private func tapNextSongAction() {
        let count = musicManager.musicClass.count - 1
        
        if musicManager.numberOfMusic < count {
            musicManager.numberOfMusic += 1
            index += 1
        } else {
            musicManager.numberOfMusic = 0
            index = 0
        }
        configureTrack()
    }
    
    @objc private func tapPreviousSongAction() {
        let count = musicManager.musicClass.count - 1

        if musicManager.numberOfMusic == 0 {
            musicManager.numberOfMusic = count
            index = count
        } else if musicManager.numberOfMusic <= count {
            musicManager.numberOfMusic -= 1
            index -= 1
        }
        configureTrack()
    }
    
    @objc private func tapPlayButton() {
        guard let player = musicManager.player else { return }

        if player.isPlaying {
            player.pause()
            views.playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            views.playButton.isSelected = false
        } else {
            player.play()
            views.playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            views.playButton.isSelected = true
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicManager.musicClass.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        let picture = UIImage(named: musicManager.musicClass[indexPath.row].image)
        
        cell.image.image = picture

        return cell
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexPath = IndexPath(row: index, section: 0)
        
        layout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
