//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Александр Касьянов on 11.03.2022.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: CollectionViewModel? {
        didSet {
            guard let imageName = photo?.image else {return}
            photoGalleryImages.image = UIImage(named: imageName)
        }
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.clipsToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        return view
    }()
  
    lazy var photoGalleryImages: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(photoGalleryImages)
        NSLayoutConstraint.activate([
            photoGalleryImages.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            photoGalleryImages.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            photoGalleryImages.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            photoGalleryImages.widthAnchor.constraint(equalTo: self.contentView.widthAnchor)
        ])
    }
}
