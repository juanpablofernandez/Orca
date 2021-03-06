//
//  Answer.swift
//  Orca
//
//  Created by Jay on 3/23/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

struct Answer {
    var videoUrl: String?
    var thumbnailUrl: String?
    var sender: User?
    var receiver: User?
    
    var questionId: Int?
    var content: String?
    
    var likesCount: Int?
    var dataId: Int?
    var commentCount: Int?
}

struct AnswerPage {
    var answers = [Answer]()
    var page: Int?
    var totalPages: Int?
    var perPage: Int?
}
