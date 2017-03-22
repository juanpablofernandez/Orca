//
//  SignInButton.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class profileButton: UIButton {
    
    var buttonIcon: UIImageView = {
        let image = UIImage(named: "")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var buttonLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Lato-Bold", size: 18)
        label.textColor = UIColor.white
        label.highlightedTextColor = UIColor(hex: "#DEDEDE")
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(handleTouchExit), for: .touchDragExit)
        self.addTarget(self, action: #selector(handleTouchCancel), for: .touchCancel)
        self.addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        buttonIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonIcon)
        buttonIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        buttonIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        buttonIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLabel)
        buttonLabel.leftAnchor.constraint(equalTo: buttonIcon.rightAnchor, constant: 8).isActive = true
        buttonLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        buttonLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        buttonLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func handleTouchDown() {
        self.buttonLabel.isHighlighted = true
        self.buttonIcon.isHighlighted = true
    }
    
    func handleTouchExit() {
        self.buttonLabel.isHighlighted = false
        self.buttonIcon.isHighlighted = false
    }
    
    func handleTouchCancel() {
        self.buttonLabel.isHighlighted = false
        self.buttonIcon.isHighlighted = false
    }
    
    func handleTouchUpInside() {
        
        UILabel.animate(withDuration: 1, animations: {
            self.buttonLabel.isHighlighted = true
            self.buttonIcon.isHighlighted = true
        }, completion: { (finish: Bool) in
            UILabel.animate(withDuration: 1, animations: {
                self.buttonLabel.isHighlighted = false
                self.buttonIcon.isHighlighted = false
            })
        })
    }
}
