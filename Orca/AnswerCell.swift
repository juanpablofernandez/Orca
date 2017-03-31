//
//  AnswerCell.swift
//  Orca
//
//  Created by Jay on 3/29/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class AnswerCell: UICollectionViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        return label
    }()
    
    var answerTextField: UILabel = {
        let field = UILabel()
        field.numberOfLines = 0
        return field
    }()
    
    var videoSnapshot: AnswerSnapshotView = {
        let imageView = AnswerSnapshotView(frame: CGRect.zero)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
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

        self.addSubview(answerTextField)
        answerTextField.translatesAutoresizingMaskIntoConstraints = false
        answerTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        answerTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        answerTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true

        self.addSubview(videoSnapshot)
        videoSnapshot.translatesAutoresizingMaskIntoConstraints = false
        videoSnapshot.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        videoSnapshot.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        videoSnapshot.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 10).isActive = true
        videoSnapshot.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
