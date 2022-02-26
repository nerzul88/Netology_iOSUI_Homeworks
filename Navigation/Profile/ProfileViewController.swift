//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        //self.navigationController?.navigationBar.backgroundColor = .white

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
