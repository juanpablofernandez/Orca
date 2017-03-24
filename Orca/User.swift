//
//  User.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit

struct User {
    
    var id: String?
    var username: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var imageUrl: String?
    var followingCount: Int?
    var followerCount: Int?

    static var sharedInstance = User()
    
    init() {}
}
