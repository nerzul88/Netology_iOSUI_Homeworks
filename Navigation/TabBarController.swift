//
//  TabBarController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        tabBar.backgroundColor = .white
        setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        
        return navController
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: FeedViewController(), title: NSLocalizedString("Feed", comment: ""), image: UIImage(systemName: "house")!),
            //createNavController(for: ProfileViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
            createNavController(for: LogInViewController(), title: NSLocalizedString("Log In", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
}
