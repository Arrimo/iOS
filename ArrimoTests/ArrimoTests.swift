//
//  ArrimoTests.swift
//  ArrimoTests
//
//  Created by JJ Zapata on 4/15/21.
//

import XCTest
@testable import Arrimo

class ArrimoAuthTests: XCTestCase {
    
    var signInController : SignInController!
    
    override func setUpWithError() throws {
        signInController = SignInController()
        signInController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        signInController = nil
    }
    
    func testEmailTextField_ContentType() throws {
        let emailTextField = try XCTUnwrap(signInController.emailTextField, "Password Text Field Keyboard Style Incorrect")
        XCTAssertEqual(emailTextField.keyboardType, .emailAddress)
    }
    
    func testPasswordTextField_ContentType() throws {
        let passwordTextField = try XCTUnwrap(signInController.passwordTextField, "Password Text Field Is Not Secured Text")
        XCTAssertEqual(passwordTextField.isSecureTextEntry, true)
    }
    
}

class ArrimoRunMyDayTests: XCTestCase {
    
    var welcomeController : WelcomeController!
    
    var startCommute : StartCommuteController!
    
    override func setUpWithError() throws {
        startCommute = StartCommuteController()
        startCommute.loadViewIfNeeded()
        
        welcomeController = WelcomeController()
        welcomeController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        startCommute = nil
        welcomeController = nil
    }
    
    func testMainButtonTitleLocalization() throws {
        let startCommuteButton = try XCTUnwrap(startCommute.startCommute, "Start Commute Button Not Localized")
        XCTAssertEqual(startCommuteButton.titleLabel?.text, "START\nCOMMUTE".localized())
    }
    
    func testJSONFormat() throws {
        let welcomeButton = try XCTUnwrap(welcomeController.mainButton, "No Main Button In Welcome Screen")
//        welcomeButton.
    }
    
}
