//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Касьянов on 21.02.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    weak var profileViewController: ProfileViewController?
        
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.image = UIImage(named: "Milwaukee_Bucks.jpeg")
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = titleText
        label.textAlignment = .left
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = statusText
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var alphaView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        view.backgroundColor = .white
        return view
    }()
    
    private var statusText: String = "Waiting for something..."
    private var titleText: String = "Milwaukee Bucks"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.statusTextField.delegate = self
        self.drawSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf(){

        self.addSubviews(self.infoStackView, self.setStatusButton, self.statusTextField)
        self.infoStackView.addArrangedSubviews(self.avatarImageView, self.labelsStackView)
        self.labelsStackView.addArrangedSubviews(self.fullNameLabel, self.statusLabel)
                
        NSLayoutConstraint.activate([
            self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.infoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -105),
            self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0),
            
            self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 5),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 5),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 35)
        ].compactMap({$0}))
    }
    
    func hideKeyboard() {
        self.statusTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 25
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc private func didTapStatusButton() {
        self.statusLabel.text = self.statusTextField.text
        if self.statusLabel.text == "" {
            self.statusLabel.text = self.statusText
        }
        self.statusTextField.text = ""
    }
    
}
