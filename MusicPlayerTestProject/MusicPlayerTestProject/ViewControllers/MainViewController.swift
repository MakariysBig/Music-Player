import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    let views = Views()
    let swipeGesture = UISwipeGestureRecognizer()
    var index = 0
    let layout = UICollectionViewFlowLayout()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 29/255, green: 23/255, blue: 38/255, alpha: 1)
        views.loadViews(view)
        setUpTarget()
        setUpCollectionViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Private methods
    
    private func setUpTarget() {
        views.forwardButton.addTarget(self, action: #selector(tapNextSongAction), for: .touchUpInside)
        views.backwardButton.addTarget(self, action: #selector(tapPreviousSongAction), for: .touchUpInside)
        views.playButton.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
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
    
    //MARK: - Action
    
    @objc func tapNextSongAction() {
        let count = views.musicClass.count - 1
        
        if views.numberOfMusic < count {
            views.numberOfMusic += 1
            index += 1
        } else {
            views.numberOfMusic = 0
            index = 0
        }
        let indexPath = IndexPath(row: index, section: 0)
        layout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        views.configurePlayer(numberOfMusic: views.numberOfMusic)
        views.setUpSongDesctiptionLayout(view, numberOfMusic: views.numberOfMusic)
        
        guard let player = views.player else { return }
        
        if views.playButton.isSelected == true {
            player.play()
        } else {
            player.stop()
        }
    }
    
    @objc func tapPreviousSongAction() {
        let count = views.musicClass.count - 1

        if views.numberOfMusic == 0 {
            views.numberOfMusic = count
            index = count
        } else if views.numberOfMusic <= count {
            views.numberOfMusic -= 1
            index -= 1
        }
        let indexPath = IndexPath(row: index, section: 0)
        layout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        views.configurePlayer(numberOfMusic: views.numberOfMusic)
        views.setUpSongDesctiptionLayout(view, numberOfMusic: views.numberOfMusic)
        
        guard let player = views.player else { return }
        
        if views.playButton.isSelected == true {
            player.play()
        } else {
            player.stop()
        }
    }
    
    @objc func tapPlayButton() {
        guard let player = views.player else { return }

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
        return views.musicClass.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        let picture = UIImage(named: views.musicClass[indexPath.row].image)
//        index = indexPath.row
        
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
        
        let didUseSwipeToSkipCell = false
        
        if didUseSwipeToSkipCell {
            
            
            
        } else {
            let indexPath = IndexPath(row: index, section: 0)

            layout.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        
    }
    
   
}
