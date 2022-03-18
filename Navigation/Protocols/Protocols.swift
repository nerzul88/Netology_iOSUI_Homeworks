//
//  Setupable.swift
//  Navigation
//
//  Created by Александр Касьянов on 09.03.2022.
//

import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

protocol ChangeLikesDelegate: AnyObject {
    func likesChanged(at indexPath: IndexPath)
}

protocol ChangeViewsDelegate: AnyObject {
    func viewsChanged(at indexPath: IndexPath)
}
