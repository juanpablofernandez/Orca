//
//  Comments.swift
//  Orca
//
//  Created by Jay on 4/17/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

struct Comment {
    var id: Int?
    var content: String?
    var commenter: User?
    var answerId: Int?
}

struct CommentPage {
    var comments = [Comment]()
    var page: Int?
    var totalPages: Int?
    var perPage: Int?
}
