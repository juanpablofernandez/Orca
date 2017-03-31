//
//  QuestionView.swift
//  Orca
//
//  Created by Jay on 3/30/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

class QuestionView: UIScrollView {
    
    var answer: Answer?

    init(frame: CGRect, answer: Answer) {
        super.init(frame: frame)
        self.answer = answer
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
    }

}
