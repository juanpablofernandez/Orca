//
//  AnswerSnapshotView.swift
//  Orca
//
//  Created by Jay on 3/30/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class AnswerSnapshotView: UIImageView {
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let playButton: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "player.png")
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = ""
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let likesImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "heart.png")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "comment.png")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let likeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(contentView)
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        contentView.addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(profileImage)
        profileImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.rightAnchor.constraint(equalTo: profileImage.leftAnchor, constant: -5).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        contentView.addSubview(likeStackView)
        likeStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        likeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        likeStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        likeStackView.addArrangedSubview(likesImage)
        likeStackView.addArrangedSubview(likesLabel)
        
        contentView.addSubview(commentStackView)
        commentStackView.leftAnchor.constraint(equalTo: likeStackView.rightAnchor, constant: 3).isActive = true
        commentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        commentStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        commentStackView.addArrangedSubview(commentsImage)
        commentStackView.addArrangedSubview(commentsLabel)
    }
}
