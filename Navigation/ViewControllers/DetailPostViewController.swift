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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var stackViewPost: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewLikesViews: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let image = image {
            imageView.image = UIImage(named: image)
        }
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        label.translatesAutoresizingMaskIntoConstraints = false
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
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        
    }
    
    func setupView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.stackViewPost)
        self.stackViewPost.addArrangedSubview(self.headerLabel)
        self.stackViewPost.addArrangedSubview(self.pictureImageView)
        self.stackViewPost.addArrangedSubview(self.descriptionLabel)
        self.stackViewPost.addArrangedSubview(self.stackViewLikesViews)
        self.stackViewLikesViews.addArrangedSubview(self.likesLabel)
        self.stackViewLikesViews.addArrangedSubview(self.viewsLabel)
        
        let scrollViewConstraints = self.scrollViewConstraints()
        let contentViewConstraints = self.contentViewConstraints()
        let stackViewPostConstraints = self.stackViewPostConstraints()
        
        NSLayoutConstraint.activate(
            scrollViewConstraints +
            contentViewConstraints +
            stackViewPostConstraints
        )
    }
    
    private func scrollViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let bottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let leadingConstraint = self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        let trailingConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
    }
    
    private func contentViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let centerXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let bottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        let widthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
        return [topConstraint, bottomConstraint, centerXConstraint, widthConstraint]
    }
    
    private func stackViewPostConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackViewPost.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingConstraint = self.stackViewPost.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.stackViewPost.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomConstraint = self.stackViewPost.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func stackViewLikesViewsConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackViewLikesViews.topAnchor.constraint(greaterThanOrEqualTo: self.stackViewPost.bottomAnchor, constant: 20)
        let leadingConstraint = self.stackViewLikesViews.leadingAnchor.constraint(equalTo: self.stackViewPost.leadingAnchor)
        let trailingConstraint = self.stackViewLikesViews.trailingAnchor.constraint(equalTo: self.stackViewPost.trailingAnchor)
        let bottomConstraint = self.stackViewLikesViews.bottomAnchor.constraint(equalTo: self.stackViewPost.bottomAnchor)

        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }

}
