//
//  HomeViewController.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import KeychainSwift

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = UIColor.white
        
        if !User.sharedInstance.isLoggedIn {
            let signInViewController = SignInViewController()
            present(signInViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(User.sharedInstance.isLoggedIn)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
}
