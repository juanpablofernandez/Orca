//
//  HomeViewController.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
//    var collectionView: UICollectionView!
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        } else {
            layout.estimatedItemSize = CGSize(width: 300, height: 170)
        }
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return cv
    }()
    
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
//        let layout = UICollectionViewFlowLayout()
//        
//        let width = self.view.frame.width
//        let height: CGFloat = 170
//        
//        layout.itemSize = CGSize(width: width, height: height)
//        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
//        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        
        
        
        
        
        
        
        
        
        
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
        
        //Collection View Setup
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(AnswerCell.self, forCellWithReuseIdentifier: "Cell")
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
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let width = collectionView.bounds.width
//        let height = CGFloat(170)
//        return CGSize(width: width, height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AnswerCell
        cell.backgroundColor = UIColor.lightGray
        let answer = self.answers[indexPath.row]
        let sender = answer.sender!
        cell.nameLabel.text = "\(sender.firstName!) \(sender.lastName!)"
        cell.contentField.text = answer.content!
        let snapshotURL = answer.thumbnailUrl!
        cell.snapshot.downloadedFrom(link: snapshotURL)
        cell.snapshot.contentMode = .scaleAspectFill
        
        return cell
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
