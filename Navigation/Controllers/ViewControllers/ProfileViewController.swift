//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, ChangeLikesDelegate, ChangeViewsDelegate {
    
    let headerView = ProfileHeaderView()
    
    private var dataSource: [Post] = []
    private var headerHeight: CGFloat = 220
    private var likesCount = 0
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.toAutoLayout()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.backgroundColor = .clear
        tableView.backgroundColor = .systemGray6
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        addDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

    }
    
    private func addDataSource() {
        self.dataSource.append(post1)
        self.dataSource.append(post2)
        self.dataSource.append(post3)
        
    }
    
    func viewsChanged(at indexPath: IndexPath) {
        dataSource[indexPath.row - 1].views += 1
        self.tableView.reloadData()
    }
    
    func likesChanged() {
        likesCount += 1
        self.tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.likesDelegate = self
            let article = self.dataSource[indexPath.row - 1]
            let likes = article.likes + likesCount
            self.dataSource[indexPath.row - 1].likes = likes
            let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                        image: article.image,
                                                        description: article.description,
                                                        likes: likes,
                                                        views: article.views,
                                                        isLiked: article.isLiked,
                                                        isViewed: article.isViewed)
            cell.setup(with: viewModel)
            likesCount = 0
            return cell
        }
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else {
            let vc = DetailPostViewController()
            vc.author = dataSource[indexPath.row - 1].author
            vc.descriptionText = dataSource[indexPath.row - 1].description
            vc.image = dataSource[indexPath.row - 1].image
            vc.likes = dataSource[indexPath.row - 1].likes
            vc.views = dataSource[indexPath.row - 1].views
            vc.index = indexPath
            vc.isViewed = dataSource[indexPath.row - 1].isViewed
            if !dataSource[indexPath.row - 1].isViewed {
                viewsChanged(at: indexPath)
            }
            navigationController?.pushViewController(vc, animated: true)
            dataSource[indexPath.row - 1].isViewed = true
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row != 0 {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSource.remove(at: indexPath.row - 1)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView()
        if section == 0 {
            headerView = ProfileHeaderView()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  headerHeight
    }
    
}

