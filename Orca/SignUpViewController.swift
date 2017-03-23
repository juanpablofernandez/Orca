//
//  SignUpViewController.swift
//  Orca
//
//  Created by Jay on 3/22/17.
//  Copyright © 2017 Juan Pablo Fernandez. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {
    
    var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Signup", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(UIColor.blue, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    var usernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.textColor = UIColor.gray
        field.backgroundColor = UIColor.white
        return field
    }()
    
    var firstNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "First Name"
        field.textColor = UIColor.gray
        field.backgroundColor = UIColor.white
        return field
    }()
    
    var lastNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name"
        field.textColor = UIColor.gray
        field.backgroundColor = UIColor.white
        return field
    }()
    
    var emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
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
        view.backgroundColor = UIColor.white
        viewSetup()
    }
    
    func viewSetup() {
        view.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        view.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -20).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -20).isActive = true
        
        let firstSeparatorLine = UIView()
        firstSeparatorLine.backgroundColor = UIColor.lightGray
        view.addSubview(firstSeparatorLine)
        firstSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        firstSeparatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstSeparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        firstSeparatorLine.widthAnchor.constraint(equalToConstant: 200).isActive = true
        firstSeparatorLine.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 0).isActive = true
        
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        usernameTextField.bottomAnchor.constraint(equalTo: firstSeparatorLine.topAnchor, constant: 0).isActive = true
        
        let secondSeparatorLine = UIView()
        secondSeparatorLine.backgroundColor = UIColor.lightGray
        view.addSubview(secondSeparatorLine)
        secondSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        secondSeparatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondSeparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        secondSeparatorLine.widthAnchor.constraint(equalToConstant: 200).isActive = true
        secondSeparatorLine.bottomAnchor.constraint(equalTo: usernameTextField.topAnchor, constant: 0).isActive = true
        
        view.addSubview(lastNameTextField)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lastNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lastNameTextField.bottomAnchor.constraint(equalTo: secondSeparatorLine.topAnchor, constant: 0).isActive = true
        
        let thirdSeparatorLine = UIView()
        thirdSeparatorLine.backgroundColor = UIColor.lightGray
        view.addSubview(thirdSeparatorLine)
        thirdSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        thirdSeparatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        thirdSeparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        thirdSeparatorLine.widthAnchor.constraint(equalToConstant: 200).isActive = true
        thirdSeparatorLine.bottomAnchor.constraint(equalTo: lastNameTextField.topAnchor, constant: 0).isActive = true
        
        view.addSubview(firstNameTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        firstNameTextField.bottomAnchor.constraint(equalTo: thirdSeparatorLine.topAnchor, constant: 0).isActive = true
        
        let fourthSeparatorLine = UIView()
        fourthSeparatorLine.backgroundColor = UIColor.lightGray
        view.addSubview(fourthSeparatorLine)
        fourthSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        fourthSeparatorLine.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fourthSeparatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        fourthSeparatorLine.widthAnchor.constraint(equalToConstant: 200).isActive = true
        fourthSeparatorLine.bottomAnchor.constraint(equalTo: firstNameTextField.topAnchor, constant: 0).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: fourthSeparatorLine.topAnchor, constant: 0).isActive = true
    }
    
    func handleCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleSignup() {
        //Check if Fields are valid:
        guard let username = usernameTextField.text, !username.isEmpty, let firstName = firstNameTextField.text, !firstName.isEmpty, let lastName = lastNameTextField.text, !lastName.isEmpty, let password = passwordTextField.text, !password.isEmpty, let email = emailTextField.text, !email.isEmpty else { return }
        
        //Signup User:
        NetworkHelper.signUp(username: username, firstName: firstName, lastName: lastName, password: password, email: email) { (result) in
            switch result {
            case let .success(user):
                print("Successfully created user", user.firstName! as String)
                self.dismiss(animated: true, completion: nil)
            case let .failure(type):
                print(type)
            }
        }
    }
}
