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

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            nameLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
            
            answerTextField.text = "\(answer.content!)"
            self.addSubview(answerTextField)
            answerTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
            answerTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
            answerTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        }
    }

}
