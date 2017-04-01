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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        if let answer = self.answer {
            let url = URL(string: answer.videoUrl!)
            let player = AVPlayer(url: url!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.bounds
            playerLayer.videoGravity = "AVLayerVideoGravityResizeAspectFill"
            self.layer.addSublayer(playerLayer)
            player.play()
            print("Playing Video")
        }
//        let path = "HTTP_VIDEO_URL_HERE"
//        let url = URL(string: path)
//        let avAsset = AVAsset(URL: url!)
//        let avPlayerItem = AVPlayerItem(asset: avAsset)
//        
//        let avPlayer = AVPlayer(playerItem: avPlayerItem)
//        let avPlayerLayer = AVPlayerLayer(layer: avPlayer)
//        
//        avPlayerLayer.frame = self.frame
//        self.layer.addSublayer(avPlayerLayer)
//        
//        self.player = avPlayer
//        
//        self.player!.seekToTime(kCMTimeZero)
//        self.player!.play()
    }
    
    
}
