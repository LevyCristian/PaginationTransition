//
//  secondView.swift
//  pagination
//
//  Created by Levy Cristian  on 06/01/19.
//  Copyright © 2019 Levy Cristian . All rights reserved.
//

import UIKit

class SecondView: UIView {

    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Second View"
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private func setUpConstraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview{
            label.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: 1).isActive = true
            label.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: 1).isActive = true
        }
    }
    func setUp(){
        addSubview(label)
        setUpConstraints()
    }

}
