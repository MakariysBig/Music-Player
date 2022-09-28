import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Private properties
    
    let image = UIImageView()
    private let coverView = UIView()
    
    //MARK: - Initialaizing
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCoverViewLayout()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods
    
    private func setUpLayout() {
        coverView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: coverView.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: coverView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 260),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
        ])
    }
    
    private func setUpCoverViewLayout() {
        contentView.addSubview(coverView)
        
        coverView.layer.borderWidth = 1
        coverView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        coverView.layer.cornerRadius = 10
        coverView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05)
        coverView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            coverView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    //MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
}
