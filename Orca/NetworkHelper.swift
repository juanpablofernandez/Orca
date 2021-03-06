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
    case parseError
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
    
    static func getAnswers(page: Int, itemsInPage: Int, completion: @escaping (Result<AnswerPage>) -> Void) {
        guard let authToken = DataHelper.getFromKeychain(key: "authToken") else { return }
        
        let params: [String: Int] = [
            "page": page - 1,
            "per_page": itemsInPage
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": authToken,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/answers", method: .get, parameters: params, headers: headers).responseJSON { (response) in
            
            return completion(parseAnswers(response: response))
        }
    }
    
    static func getComments(page: Int, itemsInPage: Int, answerId: Int, completion: @escaping (Result<CommentPage>) -> Void) {
        guard let authToken = DataHelper.getFromKeychain(key: "authToken") else { return }
        
        let params: [String: Int] = [
            "page": page - 1,
            "per_page": itemsInPage
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": authToken,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/answers/\(answerId)/comments?per_page=10&page=0", method: .get, parameters: params, headers: headers).responseJSON { (response) in
            return completion(parseComments(response: response))
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
    
    static func parseComments(response: DataResponse<Any>) -> (Result<CommentPage>) {
        switch response.result {
        case .success:
            let response = JSON(response.result.value as Any)
            var page = CommentPage()
            page.totalPages = response["total_pages"].int
            page.perPage = response["per_page"].int
            page.page = response["page"].int
            
            let data = response["data"]
            
            for i in 0..<data.count {
                var comment = Comment()
                let item = data[i]
                
                comment.id = item["id"].intValue
                comment.content = item["content"].stringValue
                comment.commenter = parseUserInfo(response: item["commenter"])
                comment.answerId = item["answer_id"].intValue
                
                page.comments.append(comment)
            }
            
            return Result.success(page)
            
        case .failure:
            return Result.failure(APIError.responseError)
        }
    }
    
    static func parseAnswers(response: DataResponse<Any>) -> (Result<AnswerPage>)  {
        switch response.result {
        case .success:
            let response = JSON(response.result.value as Any)
            var page = AnswerPage()
            page.totalPages = response["total_pages"].int
            page.perPage = response["per_page"].int
            page.page = response["page"].int
            
            let data = response["data"]
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
                
                page.answers.append(answer)
            }
            
            return Result.success(page)
            
        case .failure:
            return Result.failure(APIError.responseError)
        }
    }
}
