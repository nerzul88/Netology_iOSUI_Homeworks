//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Show alert", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            self.alertButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            self.alertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            self.alertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            self.alertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func showAlert() {
        let ac = UIAlertController(title: "Alert controller", message: "Test alert controller", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Test", style: .default, handler: { _ in print("Test print")
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
}
