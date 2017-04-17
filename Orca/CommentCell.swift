//
//  CommentCell.swift
//  Orca
//
//  Created by Jay on 4/5/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        return label
    }()
    
    var commentTextField: UILabel = {
        let field = UILabel()
        field.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
        field.numberOfLines = 0
        return field
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.clipsToBounds = true
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.addSubview(commentTextField)
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        commentTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        commentTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        commentTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        
//        let line = UIView()
//        line.backgroundColor = .white
//        line.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(line)
//        line.translatesAutoresizingMaskIntoConstraints = false
//        line.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
//        line.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
//        line.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 0).isActive = true
//        line.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
}
