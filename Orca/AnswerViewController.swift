//
//  AnswerViewController.swift
//  Orca
//
//  Created by Jay on 3/30/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import AVFoundation

class AnswerViewController: UIViewController {
    
    var answer: Answer?
    
    var videoView: PlayerView = {
        let view = PlayerView(frame: CGRect.zero)
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var questionView: QuestionView = {
        let view = QuestionView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var exitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "exit.png"), for: .normal)
        button.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        self.videoView.answer = self.answer
    }
    
    func setup() {
        if let answer = answer {
            questionView.answer = self.answer
            view.addSubview(questionView)
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            questionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            questionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            
            view.addSubview(videoView)
            videoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            videoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            videoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            videoView.bottomAnchor.constraint(equalTo: questionView.topAnchor, constant: 0).isActive = true
            
            view.addSubview(exitButton)
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
            exitButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            exitButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        }
    }
    
    func handleExit() {
        self.dismiss(animated: true, completion: nil)
    }
}
