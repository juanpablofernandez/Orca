//
//  QuestionView.swift
//  Orca
//
//  Created by Jay on 3/30/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class QuestionView: UIScrollView {
    
    var answer: Answer? {
        didSet {
            setup()
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var answerTextField: UILabel = {
        let field = UILabel()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.numberOfLines = 0
        return field
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "32"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "234"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        return label
    }()
    
    let likesImage: UIImageView = {
        let view = UIImageView()
        let image = UIImage(named: "heartOutline.png")?.enableMask()
        view.image = image
        view.tintColor = .darkGray
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "commentOutline.png")?.enableMask()
        view.tintColor = .darkGray
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
    
    let viewCommentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Comments", for: .normal)
//        button.setTitleColor(.darkGray, for: .normal)
//        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        if let answer = self.answer {
            nameLabel.text = "\(answer.sender!.firstName!) \(answer.sender!.lastName!)"
            self.addSubview(nameLabel)
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
            nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
            answerTextField.text = "\(answer.content!)"
            self.addSubview(answerTextField)
            answerTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            answerTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            answerTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
            
            likesLabel.text = "\(answer.likesCount!)"
            self.addSubview(likeStackView)
            likeStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
            likeStackView.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 5).isActive = true
            likeStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            likeStackView.addArrangedSubview(likesImage)
            likeStackView.addArrangedSubview(likesLabel)
            
            commentsLabel.text = "\(answer.commentCount!)"
            self.addSubview(commentStackView)
            commentStackView.leftAnchor.constraint(equalTo: likeStackView.rightAnchor, constant: 3).isActive = true
            commentStackView.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 5).isActive = true
            commentStackView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            commentStackView.addArrangedSubview(commentsImage)
            commentStackView.addArrangedSubview(commentsLabel)
            
            self.addSubview(viewCommentsButton)
            viewCommentsButton.leftAnchor.constraint(equalTo: commentStackView.rightAnchor, constant: 20).isActive = true
//            viewCommentsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            viewCommentsButton.centerYAnchor.constraint(equalTo: commentStackView.centerYAnchor).isActive = true
            
        }
    }

}
