//
//  DetailPostView.swift
//  Navigation
//
//  Created by Александр Касьянов on 22.03.2022.
//

import UIKit

class DetailPhotoView: UIView {
    
    var photoImage: UIImage?

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let photo = photoImage {
            imageView.image = photo
        }
        return imageView
    }()
    
    private lazy var exitButton: UIButton = {
        let exitButton = UIButton()
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle("X", for: .normal)
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        exitButton.backgroundColor = .gray
        exitButton.layer.cornerRadius = 10
        return exitButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //configureTableView()
        drawSelf()
        self.backgroundColor = .white
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func drawSelf() {
        
        var constraints = [NSLayoutConstraint]()
        
        self.addSubview(exitButton)
        self.addSubview(photoImageView)
        
        constraints.append(exitButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(exitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30))
        constraints.append(exitButton.widthAnchor.constraint(equalToConstant: 20))
        constraints.append(exitButton.heightAnchor.constraint(equalToConstant: 10))
        
        constraints.append(photoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(photoImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(photoImageView.topAnchor.constraint(equalTo: self.exitButton.bottomAnchor, constant: 10))
        constraints.append(photoImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))

        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc func exitTapped() {
        
        //let postViewCell = PostHeaderViewCell()

        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
            //postViewCell.viewsPost.text = "test"
            print("Exit button has tapped")
        }
    }
}
