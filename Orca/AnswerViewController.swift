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
    
    var videoControl: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "play.png"), for: .normal)
        button.addTarget(self, action: #selector(handlePlayAndPause), for: .touchUpInside)
        return button
    }()
    
    var currentVideoState: VideoState = .paused

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        self.videoView.answer = self.answer
    }
    
    var questionViewTopAnchor: NSLayoutConstraint?
    
    func setup() {
        if let answer = answer {
            
            view.addSubview(videoView)
            videoView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            videoView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            videoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            videoView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
            
            questionView.viewCommentsButton.addTarget(self, action: #selector(handleComments), for: .touchUpInside)
            questionView.answer = self.answer
            view.addSubview(questionView)
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            questionView.heightAnchor.constraint(equalToConstant: view.bounds.height + 100).isActive = true
//            questionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
            questionViewTopAnchor = questionView.topAnchor.constraint(equalTo: videoView.bottomAnchor)
            questionViewTopAnchor?.isActive = true
            
            view.addSubview(videoControl)
            videoControl.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
            videoControl.bottomAnchor.constraint(equalTo: videoView.bottomAnchor, constant: -20).isActive = true
            videoControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
            videoControl.widthAnchor.constraint(equalToConstant: 40).isActive = true
            
            view.addSubview(exitButton)
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
            exitButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            exitButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        }
    }
    
    func handlePlayAndPause(sender: UIButton) {
        if currentVideoState == .paused {
            sender.setImage(UIImage(named: "pause.png"), for: .normal)
            currentVideoState = .playing
            videoView.playVideo()
            
        } else {
            sender.setImage(UIImage(named: "play.png"), for: .normal)
            currentVideoState = .paused
            videoView.pausePlayer()
        }
    }
    
    func handleComments() {
        let height = videoView.bounds.height + 100
        self.questionViewTopAnchor?.constant = -height
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func handleExit() {
        videoView.pausePlayer()
        self.dismiss(animated: true, completion: nil)
    }
}

enum VideoState {
    case playing
    case paused
}
