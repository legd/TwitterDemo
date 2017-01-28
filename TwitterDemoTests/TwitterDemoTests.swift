//
//  TwitterDemoTests.swift
//  TwitterDemoTests
//
//  Created by Luis Guzman on 1/26/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import XCTest
@testable import TwitterDemo

class TwitterDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginViewUserIsEmpty() {
        let loginViewController = LoginViewController()
        let loginButton = UIButton()
        let userName = UITextField()
        
        userName.text = ""
        loginViewController.userName = userName
        loginViewController.loginBtnPressed(loginButton)
        
        XCTAssertEqual(UIColor.red, loginViewController.userName.backgroundColor)
    }
    
    func testLoginViewUserIsValid() {
        let loginViewController = LoginViewController()
        let loginButton = UIButton()
        let userName = UITextField()
        let userPassword = UITextField()
        
        userName.text = "test"
        userPassword.text = ""
        loginViewController.userName = userName
        loginViewController.password = userPassword
        loginViewController.loginBtnPressed(loginButton)
        
        XCTAssertNotEqual(UIColor.red, loginViewController.userName.backgroundColor)
    }
    
    func testLoginViewPasswordIsEmpty() {
        let loginViewController = LoginViewController()
        let loginButton = UIButton()
        let userName = UITextField()
        let userPassword = UITextField()
        
        userName.text = "test"
        userPassword.text = ""
        loginViewController.userName = userName
        loginViewController.password = userPassword
        loginViewController.loginBtnPressed(loginButton)

        XCTAssertEqual(UIColor.red, loginViewController.password.backgroundColor)
    }
    
    func testLoginViewPasswordIsValid() {
        let loginViewController = LoginViewController()
        let loginButton = UIButton()
        let userName = UITextField()
        let userPassword = UITextField()
        
        userName.text = "test"
        userPassword.text = "test"
        loginViewController.userName = userName
        loginViewController.password = userPassword
        loginViewController.loginBtnPressed(loginButton)
        
        XCTAssertNotEqual(UIColor.red, loginViewController.password.backgroundColor)
    }
    
}
