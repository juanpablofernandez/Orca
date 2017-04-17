//
//  CommentsViewController.swift
//  Orca
//
//  Created by Jay on 4/5/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    var comments = [Comment]()
    var isPageRefreshing: Bool = false
    var currentPageIndex: Int = 0
    var totalPages: Int = 0
    var answerId: Int?
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionViewSetup()
        getComments(currentPage: 1, itemsInPage: 10, answerId: answerId!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.bounds.size.height) {
            if !isPageRefreshing {
                if currentPageIndex < totalPages {
                    isPageRefreshing = true
                    currentPageIndex += 1
                    getComments(currentPage: currentPageIndex, itemsInPage: 10, answerId: answerId!)
                }
            }
        }
    }
    
    func collectionViewSetup() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func getComments(currentPage: Int, itemsInPage: Int, answerId: Int) {
        NetworkHelper.getComments(page: currentPage, itemsInPage: itemsInPage, answerId: answerId) { (result) in
            switch result {
            case let .success(page):
                if self.currentPageIndex == 1 {
                    self.comments = page.comments
                } else {
                    self.comments += page.comments
                }
                self.totalPages = page.totalPages!
                self.isPageRefreshing = false
                self.collectionView.reloadData()
            case let .failure(type):
                print(type)
            }
        }
    }
    
    func estimateFrameForComment(text: String) -> CGRect {
        let size = CGSize(width: collectionView.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
}

extension CommentsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        var height: CGFloat = 50
        
        if let text = self.comments[indexPath.row].content {
            height = estimateFrameForComment(text: text).height + 45
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CommentCell
        let index = indexPath.row
        cell.backgroundColor = .lightGray
        cell.commentTextField.text = comments[index].content
        let commenter = comments[index].commenter!
        cell.nameLabel.text = "\(commenter.firstName!) \(commenter.lastName!)"
        return cell
    }
    
    
}

