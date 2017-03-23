//
//  NetworkHelper.swift
//  Orca
//
//  Created by Jay on 3/23/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KeychainSwift

enum APIError: Swift.Error {
    case responseError
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

class NetworkHelper {
    
    //    static func networkRequest(url: String, method: HTTPMethod, parameters: [String: String]) {
    //        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
    //
    //        }
    //    }
    
    static func signIn(email: String, password: String, completion: @escaping (Result<User>) -> Void)  {
        let params: [String: String] = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/sessions", method: .post, parameters: params).responseJSON { (response) in
            
            return completion(self.parseLogin(response: response))
        }
    }
    
    static func signUp(username: String, firstName: String, lastName: String, password: String, email: String, completion: @escaping (Result<User>)  -> Void) {
        let params: [String: String] = [
            "email": email,
            "first_name": firstName,
            "last_name": lastName,
            "password": password,
            "username": username
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/users", method: .post, parameters: params).responseJSON { (response) in
            
            return completion(self.parseLogin(response: response))
        }
    }
    
    static func parseLogin(response: DataResponse<Any>) -> (Result<User>)  {
        switch response.result {
        case .success:
            let headerFields = JSON(response.response?.allHeaderFields as Any)
            let authToken = headerFields["Authorization"].stringValue
            let response = JSON(response.result.value as Any)
            var user = User()
            user.imageUrl = response["image_url"].stringValue
            user.firstName = response["first_name"].stringValue
            user.lastName = response["last_name"].stringValue
            user.id = response["id"].stringValue
            user.email = response["email"].stringValue
            user.followerCount = response["follower_count"].intValue
            user.followingCount = response["following_count"].intValue
            user.username = response["username"].stringValue
            user.isLoggedIn = true
            
            //Save Auth Token to the Keychain:
            let keychain = KeychainSwift()
            keychain.set(authToken, forKey: "authToken")
            
            User.sharedInstance = user
            return Result.success(user)
            
        case .failure:
            return Result.failure(APIError.responseError)
        }
    }
}
