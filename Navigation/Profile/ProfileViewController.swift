//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileHeaderView)
        profileHeaderView.statusTextField.delegate = self

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderViewSetup()
    }
    
    private func profileHeaderViewSetup() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileHeaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            profileHeaderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            profileHeaderView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func hideKeyboard() {
        profileHeaderView.statusTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}
