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

enum APIError: Swift.Error {
    case responseError
}

enum Result<T> {
    case success(T)
    case failure(APIError)
}

class NetworkHelper {
    static func signIn(email: String, password: String, completion: @escaping (Result<User>) -> Void)  {
        let params: [String: String] = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/sessions", method: .post, parameters: params).responseJSON { (response) in
            
            return completion(self.parseUser(response: response))
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
            
            return completion(self.parseUser(response: response))
        }
    }
    
    static func getAnswers(page: Int, per_page: Int, completion: @escaping (Result<[Answer]>)  -> Void) {
        
        guard let authToken = DataHelper.getFromKeychain(key: "authToken") else { return }
        
        let params: [String: Int] = [
            "page": page,
            "per_page": per_page
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": authToken,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/answers", method: .get, parameters: params, headers: headers).responseJSON { (response) in
            
            return completion(parseAnswers(response: response))
        }
    }
    
    static func parseUser(response: DataResponse<Any>) -> (Result<User>)  {
        switch response.result {
        case .success:
            let headerFields = JSON(response.response?.allHeaderFields as Any)
            let authToken = headerFields["Authorization"].stringValue
            let response = JSON(response.result.value as Any)
            
            let user = parseUserInfo(response: response)
            
            //Save Auth Token to the Keychain:
            DataHelper.saveToKeychain(key: "authToken", data: authToken)
            
            User.sharedInstance = user
            return Result.success(user)
            
        case .failure:
            return Result.failure(APIError.responseError)
        }
    }
    
    static func parseUserInfo(response: JSON) -> (User)  {
        var user = User()
        user.imageUrl = response["image_url"].stringValue
        user.firstName = response["first_name"].stringValue
        user.lastName = response["last_name"].stringValue
        user.id = response["id"].stringValue
        user.email = response["email"].stringValue
        user.followerCount = response["follower_count"].intValue
        user.followingCount = response["following_count"].intValue
        user.username = response["username"].stringValue
        
        return user
    }
    
    static func parseAnswers(response: DataResponse<Any>) -> (Result<[Answer]>)  {
        switch response.result {
        case .success:
            let response = JSON(response.result.value as Any)
            let data = response["data"]
            var answers: [Answer] = []
            for i in 0...data.count - 1 {
                var answer = Answer()
                let item = data[i]
                
                answer.videoUrl = item["video_url"].stringValue
                answer.thumbnailUrl = item["thumbnail_url"].stringValue
                
                answer.sender = parseUserInfo(response: item["question"]["sender"])
                answer.receiver = parseUserInfo(response: item["question"]["receiver"])

                answer.questionId = item["question"]["id"].intValue
                answer.content = item["question"]["content"].stringValue
                
                answer.likesCount = item["likes_count"].intValue
                answer.dataId = item["id"].intValue
                answer.commentCount = item["comment_count"].intValue
                
                answers.append(answer)
            }
            
            return Result.success(answers)
            
        case .failure:
            return Result.failure(APIError.responseError)
        }
    }
}
