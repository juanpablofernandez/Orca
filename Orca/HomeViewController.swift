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
        let layout = UICollectionViewFlowLayout()
        
//        layout.itemSize = CGSize(width: width, height: height)
//        layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
        
        //Collection View Setup
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(AnswerCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
        // Anchors:
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
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
    
    func estimateFrameForQuestion(text: String) -> CGRect {
        let size = CGSize(width: self.collectionView.frame.width, height: 1000)
        let options =  NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        var height: CGFloat = 280
        
        if let text = self.answers[indexPath.row].content {
            height = estimateFrameForQuestion(text: text).height + 255
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AnswerCell
        let answer = self.answers[indexPath.row]
        let sender = answer.sender!
        let receiver = answer.receiver!
        cell.nameLabel.text = "\(sender.firstName!) \(sender.lastName!)"
        cell.answerTextField.text = answer.content!
        let snapshotURL = answer.thumbnailUrl!
        cell.videoSnapshot.downloadedFrom(link: snapshotURL)
        cell.videoSnapshot.contentMode = .scaleAspectFill
        cell.videoSnapshot.likesLabel.text = answer.likesCount?.description
        cell.videoSnapshot.commentsLabel.text = answer.commentCount?.description
        cell.videoSnapshot.nameLabel.text = "\(receiver.firstName!) \(receiver.lastName!)"
        let profileImageURL = receiver.imageUrl!
        cell.videoSnapshot.profileImage.downloadedFrom(link: profileImageURL)
        cell.videoSnapshot.profileImage.contentMode = .scaleAspectFit
        
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
