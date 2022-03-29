//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Александр Касьянов on 10.03.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private lazy var backView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var stackViewLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var firstImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "SJ_img01")
        return imageView
    }()
    
    private lazy var secondImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "SJ_img02")
        return imageView
    }()
    
    private lazy var thirdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "SJ_img03")
        return imageView
    }()
    
    private lazy var fourthImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.image = UIImage(named: "SJ_img04")
        return imageView
    }()

    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Photos"
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let arrow = UIImage(systemName: "arrow.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = arrow
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.stackViewVertical)
        self.stackViewLabels.addArrangedSubviews(self.photosLabel, self.arrowImageView)
        self.stackViewVertical.addArrangedSubviews(self.stackViewLabels, self.stackViewHorizontal)
        self.stackViewHorizontal.addArrangedSubviews(self.firstImageView,
                                                     self.secondImageView,
                                                     self.thirdImageView,
                                                     self.fourthImageView)
        
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.backView.heightAnchor.constraint(equalToConstant: 140),
            
            self.stackViewVertical.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12),
            self.stackViewVertical.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -12),
            self.stackViewVertical.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            self.stackViewVertical.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
            
            self.arrowImageView.heightAnchor.constraint(equalTo: self.arrowImageView.widthAnchor, multiplier: 0.8),
            self.arrowImageView.widthAnchor.constraint(equalTo: self.arrowImageView.heightAnchor, multiplier: 1.0),
            self.stackViewLabels.heightAnchor.constraint(equalToConstant: 12)
            ])
    }
    
}
