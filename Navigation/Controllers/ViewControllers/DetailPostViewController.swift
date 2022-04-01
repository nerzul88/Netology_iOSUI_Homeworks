//
//  DetailPostViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.03.2022.
//

import UIKit

class DetailPostViewController: UIViewController {
    
    var author: String?
    var descriptionText: String?
    var image: String?
    var likes: Int?
    var views: Int?
    var index: IndexPath?
    var isViewed: Bool?
    
    private var viewsCount = 0
    
    private func updateViews() {
        if var views = views {
            if let viewed = isViewed {
                if !viewed {
                    views += 1
                    viewsCount = views
                } else {
                    viewsCount = views
                }
            }
        }
    }
    
    weak var viewsDelegate: ChangeViewsDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackViewPost: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewLikesViews: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = author
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return label
    }()
    
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        if let image = image {
            imageView.image = UIImage(named: image)
        }
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 0
        label.font = UIFont(name: "System", size: 14)
        label.textColor = .systemGray
        label.text = descriptionText
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        updateViews()
        label.toAutoLayout()
        label.backgroundColor = .clear
        label.font = UIFont(name: "System", size: 16)
        label.textColor = .black
        if let likes = likes {
            label.text = "Likes: \(likes)"
        }
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.backgroundColor = .clear
        label.font = UIFont(name: "System", size: 16)
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        label.text = "Views: \(viewsCount)"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        guard let index = index else {return}
        guard let viewed = isViewed else {return}
        if !viewed {
            self.viewsDelegate?.viewsChanged(at: index)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.stackViewPost)
        self.stackViewPost.addArrangedSubviews(self.headerLabel, self.pictureImageView, self.descriptionLabel, self.stackViewLikesViews)
        self.stackViewLikesViews.addArrangedSubviews(self.likesLabel, self.viewsLabel)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: navigationController?.navigationBar.frame.height ?? 50),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            self.stackViewPost.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.stackViewPost.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.stackViewPost.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.stackViewPost.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    


}
