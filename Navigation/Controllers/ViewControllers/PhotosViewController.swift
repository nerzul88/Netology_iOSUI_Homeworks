//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 11.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let detailPhotoView = DetailPhotoView()

    private enum Constants {
        static let itemCount: CGFloat = 3
    }
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        return collectionView
    }()

    private var collectionDataSource : [CollectionViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourceSetup()
        self.setupView()
        self.title = "Photo Gallery"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
    }

    
    private func setupView() {
        
        self.view.backgroundColor = .white
        self.detailPhotoView.toAutoLayout()
        self.view.addSubviews(self.collectionView, self.detailPhotoView)

        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: navigationController?.navigationBar.frame.height ?? 50),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.detailPhotoView.topAnchor.constraint(equalTo: view.topAnchor),
            self.detailPhotoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.detailPhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.detailPhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 4 * spacing
        let itemWidth = floor(neededWidth / Constants.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    private func dataSourceSetup() {
        for n in 1...21 {
            var name = ""
            if n / 10 < 1 {
                name = "SJ_img0\(n)"
            } else {
                name = "SJ_img\(n)"
            }
            collectionDataSource.append(CollectionViewModel(image: name))
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCollectionCell", for: indexPath)
            cell.backgroundColor = .black
            return cell
        }
        cell.backgroundColor = .systemGray6
        let photo = collectionDataSource[indexPath.row]
        cell.photo = photo
        cell.photoGalleryImages.contentMode = .scaleAspectFill
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5) {
            
            let image = self.collectionDataSource[indexPath.item].image
            
            self.detailPhotoView.set(image: image)
            self.detailPhotoView.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
