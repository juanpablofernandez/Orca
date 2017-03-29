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
        return label
    }()
    
    var contentField: UILabel = {
        let field = UILabel()
        field.numberOfLines = 0
        return field
    }()
    
    var snapshot: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
//    var desiredSize: CGSize = CGSize(width: 200, height: 170)
//    var cachedSize: CGSize?
    
    var isHeightCalculated: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
//            let attributes = super.preferredLayoutAttributesFitting(layoutAttributes.size)
//            attributes.size.width = 300
//            attributes.size.height = self.nameLabel.frame.height + self.contentField.frame.height + self.snapshot.frame.height + 30
//            isHeightCalculated = true
            
            let height = self.nameLabel.bounds.height + self.contentField.frame.height/10 + self.snapshot.bounds.height + 30
            print("//////////////////////////////")
            print(nameLabel.bounds.height)
            print(contentField.bounds.height)
            print(snapshot.bounds.height)
            print(height)
            
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.height = CGFloat(ceilf(Float(height)))
            newFrame.size.width = CGFloat(ceilf(Float(350)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
            
        }
        
        return layoutAttributes
    }
    
//    func setup() {
//        self.clipsToBounds = true
//        
//        
////        nameLabel.translatesAutoresizingMaskIntoConstraints = false
////        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
////        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        //        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        
//        
////                contentField.translatesAutoresizingMaskIntoConstraints = false
//        //        contentField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
//        //        contentField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
////        contentField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
//        contentField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        
//        
////        snapshot.translatesAutoresizingMaskIntoConstraints = false
////        snapshot.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
////        snapshot.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        //        snapshot.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 10).isActive = true
//        snapshot.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        //        snapshot.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        
//        let stackView = UIStackView()
//        
//        stackView.axis = .vertical
//        stackView.distribution = .fillProportionally
//        stackView.alignment = .center
//        stackView.spacing = 10
//        
//        stackView.addArrangedSubview(nameLabel)
//        stackView.addArrangedSubview(contentField)
//        stackView.addArrangedSubview(snapshot)
//        
//        self.addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
//        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
//        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
//        
//    }
    
    func setup() {
        self.clipsToBounds = true

        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        self.addSubview(contentField)
        contentField.backgroundColor = .red
        contentField.translatesAutoresizingMaskIntoConstraints = false
        contentField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        contentField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        contentField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
//            contentField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        self.addSubview(snapshot)
        snapshot.translatesAutoresizingMaskIntoConstraints = false
        snapshot.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        snapshot.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        snapshot.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 10).isActive = true
        snapshot.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        snapshot.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
