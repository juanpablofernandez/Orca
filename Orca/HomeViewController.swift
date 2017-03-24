//
//  HomeViewController.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var answers = [Answer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = UIColor.white
        collectionViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !DataHelper.isKeyInKeychain(key: "authToken") {
            let signInViewController = SignInViewController()
            present(signInViewController, animated: true, completion: nil)
        } else {
            getAnswers()
        }
    }
    
    func collectionViewSetup() {
        //Collection View Layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        //Collection View Setup
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        // Anchors:
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44).isActive = true
    }
    
    func getAnswers() {
        NetworkHelper.getAnswers(page: 0, per_page: 20) { (result) in
            switch result {
            case let .success(answers):
                self.answers = answers
                self.collectionView.reloadData()
            case let .failure(type):
                print(type)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
}
