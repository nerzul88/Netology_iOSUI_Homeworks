//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Касьянов on 17.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
//    var isLiked = false
    
//    private var likesCount = 0 {
//        didSet {
//            updateLikes(with: likesCount)
//        }
//    }
//
//    public func addLike() {
//        likesCount += 1
//    }
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var setTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(didTapSetTitleButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var heightConstraint: NSLayoutConstraint?
    
    private var dataSource: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        profileHeaderViewSetup()
        setTitleButtonSetup()
        setupTableView()
        addDataSource()
        print(dataSource.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func profileHeaderViewSetup() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.profileHeaderView)
        
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            self.heightConstraint
        ].compactMap({$0}))
    }
    
    private func setTitleButtonSetup() {
        self.view.addSubview(setTitleButton)
        
        let setTitleButtonHeightConstraint = self.setTitleButton.heightAnchor.constraint(equalToConstant: 50)
        let setTitleButtonBottomConstraint = self.setTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let setTitleButtonLeadingConstraint = self.setTitleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let setTitleButtonTrailingConstraint = self.setTitleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            setTitleButtonHeightConstraint,
            setTitleButtonBottomConstraint,
            setTitleButtonLeadingConstraint,
            setTitleButtonTrailingConstraint
        ])
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        
        let tableViewTopConstraint = self.tableView.topAnchor.constraint(equalTo: self.profileHeaderView.bottomAnchor)
        let tableViewBottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.setTitleButton.topAnchor)
        let tableViewLeadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        let tableViewTrailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        NSLayoutConstraint.activate([
            tableViewTopConstraint,
            tableViewBottomConstraint,
            tableViewLeadingConstraint,
            tableViewTrailingConstraint
        ])

    }
    
    private func addDataSource() {
        self.dataSource.append(post1)
        self.dataSource.append(post2)
        self.dataSource.append(post3)
    }
    
//    public func updateLikes(with value: inout Int) {
//        isLiked.toggle()
//        value += 1
//    }
//    
//    private func updateLikesLabel(model: PostTableViewCell.ViewModel) -> PostTableViewCell.ViewModel {
//        var newModel = model
//        updateLikes(with: &newModel.likes)
//        return newModel
//    }
    
    @objc func didTapSetTitleButton() {
        let ac = UIAlertController(title: "Set title", message: "Enter new title", preferredStyle: .alert)
        ac.addTextField()
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newTitle = ac?.textFields?[0].text else {return}
            if newTitle.isEmpty {
                let ac = UIAlertController(title: "You should enter something", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                ac.addAction(okAction)
                self?.present(ac, animated: true)
            }
            self?.profileHeaderView.changeTitle(title: newTitle)
        }
        ac.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
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
            let article = self.dataSource[indexPath.row - 1]
            let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                        image: article.image,
                                                        description: article.description,
                                                        likes: article.likes,
                                                        views: article.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView( _ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
        self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        } else { return }
    }    
    
}


