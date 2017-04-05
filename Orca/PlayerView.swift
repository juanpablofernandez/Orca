//
//  PlayerView.swift
//  Orca
//
//  Created by Jay on 3/31/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    
    var setAnswer: Bool = false
    
    var answer: Answer? {
        didSet {
            if !setAnswer {
                setup()
                setAnswer = true
            }
        }
    }
    
    var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setup() {
        if let answer = self.answer {
            let url = URL(string: answer.videoUrl!)
            player = AVPlayer(url: url!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.bounds
            playerLayer.videoGravity = "AVLayerVideoGravityResizeAspectFill"
            self.layer.addSublayer(playerLayer)
            
            //Video Loop:
//            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil, using: { (_) in
//                DispatchQueue.main.async {
//                    self.player.seek(to: kCMTimeZero)
//                    self.player.play()
//                }
//            })
        }
    }
    
    func playVideo() {
        player.play()
    }
    
    func pausePlayer() {
        player.pause()
    }
}
