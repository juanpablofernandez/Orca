//
//  SignInViewController.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import Alamofire

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    var usernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.textColor = UIColor.gray
        field.backgroundColor = UIColor.white
        return field
    }()
    
    var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.textColor = UIColor.gray
        field.backgroundColor = UIColor.white
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(returnTextField))
        view.addGestureRecognizer(tap)
        viewSetup()
    }
    
    func viewSetup() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -20).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -20).isActive = true
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.lightGray
        view.addSubview(separatorLine)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        separatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorLine.widthAnchor.constraint(equalToConstant: 200).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 0).isActive = true
        
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        usernameTextField.bottomAnchor.constraint(equalTo: separatorLine.topAnchor, constant: 0).isActive = true
    }
    
    func handleLogin() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        login(username: username, password: password)
    }
    
    func login(username: String, password: String) {
        let params: [String: String] = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request("https://whale2-elixir.herokuapp.com/api/v1/sessions", method: .post, parameters: params).responseJSON { (response) in
            
            if let auth = response.response?.allHeaderFields["Authorization"] as? String {
                if let json = response.result.value as? [String: Any] {
                    User.sharedInstance.imageUrl = json["image_url"] as? String
                    User.sharedInstance.firstName = json["first_name"] as? String
                    User.sharedInstance.lastName = json["last_name"] as? String
                    User.sharedInstance.id = json["id"] as? String
                    User.sharedInstance.email = json["email"] as? String
                    User.sharedInstance.followerCount = json["follower_count"] as? Int
                    User.sharedInstance.followingCount = json["following_count"] as? Int
                    User.sharedInstance.username = json["username"] as? String
                    print("JSON: \(json)")
                    print(auth)
                    User.sharedInstance.authToken = auth
                    User.sharedInstance.isLoggedIn = true
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func returnTextField() {
        self.passwordTextField.resignFirstResponder()
        self.usernameTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnTextField()
        return true
    }
}
