//
//  Extension.swift
//  Navigation
//
//  Created by Александр Касьянов on 28.03.2022.
//

import UIKit

public extension UIView {
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    
    
}

public extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach { addArrangedSubview($0) }
    }
}
