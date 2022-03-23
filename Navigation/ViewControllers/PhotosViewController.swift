//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 11.03.2022.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let tapGestureRecognizer = UITapGestureRecognizer()
    
    private var photoViewCenterXConstraint: NSLayoutConstraint?
    private var photoViewCenterYConstraint: NSLayoutConstraint?
    private var photoViewWidthConstraint: NSLayoutConstraint?
    private var photoViewHeightConstraint: NSLayoutConstraint?
    private var photoViewTopConstraint: NSLayoutConstraint?
    private var photoViewBottomConstraint: NSLayoutConstraint?
    private var photoViewLeadingConstraint: NSLayoutConstraint?
    private var photoViewTrailingConstraint: NSLayoutConstraint?
    private var isExpanded = false
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height

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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCollectionCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var photoView: UIView = {
        var view = UIView()
        view.isHidden = true
        view.alpha = 0
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var exitButton: UIButton = {
        let exitButton = UIButton()
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.isHidden = true
        exitButton.setTitle("X", for: .normal)
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        exitButton.backgroundColor = .gray
        exitButton.layer.cornerRadius = 10
        return exitButton
    }()

    private var collectionDataSource : [CollectionViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourceSetup()
        self.setupView()
        self.title = "Photo Gallery"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    
    private func setupView() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.photoView)
        self.photoView.addSubview(self.photoImageView)
        self.photoView.addSubview(self.exitButton)
        
//        self.photoViewTopConstraint = self.photoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
//        self.photoViewBottomConstraint = self.photoView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//        self.photoViewLeadingConstraint = self.photoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
//        self.photoViewTrailingConstraint = self.photoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
//            photoViewTopConstraint,
//            photoViewBottomConstraint,
//            photoViewLeadingConstraint,
//            photoViewTrailingConstraint,
            
            self.exitButton.topAnchor.constraint(equalTo: self.photoView.topAnchor, constant: 10),
            self.exitButton.trailingAnchor.constraint(equalTo: self.photoView.trailingAnchor, constant: 10),
            self.exitButton.widthAnchor.constraint(equalToConstant: 20),
            self.exitButton.heightAnchor.constraint(equalTo: self.exitButton.widthAnchor),
            
            self.photoImageView.topAnchor.constraint(equalTo: self.exitButton.bottomAnchor, constant: 20),
            self.photoImageView.bottomAnchor.constraint(equalTo: self.photoView.bottomAnchor),
            self.photoImageView.leadingAnchor.constraint(equalTo: self.photoView.leadingAnchor),
            self.photoView.trailingAnchor.constraint(equalTo: self.photoView.trailingAnchor)
            
        ].compactMap{$0})
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
    
//    private func setupGesture() {
//        self.tapGestureRecognizer.addTarget(self, action: #selector(self.handleTapGesture(_:)))
//        self.photoView.addGestureRecognizer(self.tapGestureRecognizer)
//    }
    
//    func set(post: Photo) {
//        detailPhotoView?.photoImage = post.image
//    }
    
    @objc func exitTapped() {
        UIView.animate(withDuration: 0.5) {
            
            //postViewCell.viewsPost.text = "test"
            print("Exit button has tapped")
        }
    }
    
//    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
//        guard self.tapGestureRecognizer === gestureRecognizer else {return}
//
//        if !self.isExpanded {
//
//            NSLayoutConstraint.deactivate([
//                photoViewCenterXConstraint,
//                photoViewCenterYConstraint,
//                photoViewWidthConstraint,
//                photoViewHeightConstraint
//            ].compactMap{$0})
//
//            self.photoViewTopConstraint = self.photoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
//            self.photoViewBottomConstraint = self.photoView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
//            self.photoViewLeadingConstraint = self.photoView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
//            self.photoViewTrailingConstraint = self.photoView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
//
//            NSLayoutConstraint.activate([
//                photoViewTopConstraint,
//                photoViewBottomConstraint,
//                photoViewLeadingConstraint,
//                photoViewTrailingConstraint
//            ].compactMap{$0})
//
//            self.photoView.alpha = 1
//
//            self.isExpanded.toggle()
//        }
//
//
//
////        self.widthConstraint?.constant = self.isExpanded ? 300 : 100
////        self.heightConstraint?.constant = self.isExpanded ? 300 : 100
//
//        if self.isExpanded {
//            self.photoView.isHidden = false
//        }
//
//        UIView.animate(withDuration: 3) {
//            self.photoView.alpha = self.isExpanded ? 1 : 0
//            self.view.layoutIfNeeded()
//        } completion: { _ in
//            self.photoView.isHidden = !self.isExpanded
//        }
//
//    }
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
        let photos = collectionDataSource[indexPath.row]
        cell.photoGalleryImages.image = UIImage(named: photos.image)
        cell.photoGalleryImages.contentMode = .scaleAspectFill
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailPhotoViewController()
//        vc.selectedImage = collectionDataSource[indexPath.row].image
//        navigationController?.pushViewController(vc, animated: true)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell else {return}
        
//        self.setupGesture()
        
        NSLayoutConstraint.deactivate([
            photoViewTopConstraint,
            photoViewBottomConstraint,
            photoViewLeadingConstraint,
            photoViewTrailingConstraint
        ].compactMap{$0})
        
        self.photoViewTopConstraint = self.photoView.topAnchor.constraint(equalTo: cell.topAnchor)
        self.photoViewBottomConstraint = self.photoView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
        self.photoViewLeadingConstraint = self.photoView.leadingAnchor.constraint(equalTo: cell.leadingAnchor)
        self.photoViewTrailingConstraint = self.photoView.trailingAnchor.constraint(equalTo: cell.trailingAnchor)
        NSLayoutConstraint.activate([
            photoViewTopConstraint,
            photoViewBottomConstraint,
            photoViewLeadingConstraint,
            photoViewTrailingConstraint
        ].compactMap{$0})
        photoImageView.image = UIImage(named: collectionDataSource[indexPath.item].image)
        self.photoView.isHidden = false
        self.photoView.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let spacing = ( collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
}
