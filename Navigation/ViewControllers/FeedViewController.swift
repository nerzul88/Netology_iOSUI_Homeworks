//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("First button", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Second button", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        return button
    }()
    
    //private var post = Post()

    override func viewDidLoad() {
        super.viewDidLoad()

        drawSelf()
    }
    
    private func drawSelf() {
        self.view.addSubview(stackView)
        self.stackView.addArrangedSubview(firstButton)
        self.stackView.addArrangedSubview(secondButton)
        
        let centerYStackViewConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let leadingStackViewConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10)
        let trailingStackViewConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        let heightStackViewConstraint = self.stackView.heightAnchor.constraint(equalToConstant: 110)
        
        NSLayoutConstraint.activate([
            centerYStackViewConstraint,
            leadingStackViewConstraint,
            trailingStackViewConstraint,
            heightStackViewConstraint
        ])
    }
    
    @objc private func buttonTapped() {
        let postVC = PostViewController()
        //postVC.post = post
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
