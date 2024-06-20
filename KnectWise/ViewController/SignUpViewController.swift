//
//  SignUpViewController.swift
//  KnectWise
//
//  Created by Vijay Rathore on 31/12/23.
//

import UIKit
import Cloudinary
import CropViewController
import AuthenticationServices
import FirebaseAuth
import CryptoKit

fileprivate var currentNonce: String?
class SignUpViewController : UIViewController {
    
    var isImageSelected = false
    @IBOutlet weak var backView: UIView!

    
    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var googleBtn: UIView!

    @IBOutlet weak var loginBtn: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var appleBtn: UIView!
    
    override func viewDidLoad() {
        
        registerBtn.layer.cornerRadius = 8
    
        
        fullName.delegate = self
        emailAddress.delegate = self
        password.delegate = self
        
        googleBtn.layer.cornerRadius = 8
        googleBtn.isUserInteractionEnabled = true
        googleBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginWithGoogleBtnClicked)))
        
        
        appleBtn.layer.cornerRadius = 8
        appleBtn.isUserInteractionEnabled = true
        appleBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginWithAppleBtnClicked)))
        
        
        loginBtn.isUserInteractionEnabled = true
        loginBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        backView.layer.cornerRadius = 8
        backView.dropShadow()
        backView.isUserInteractionEnabled = true
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backBtnClicked)))
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func backBtnClicked(){
        self.dismiss(animated: true)
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        let sFullname = fullName.text
        let sEmail = emailAddress.text
        let sPassword = password.text
       
        
      if sFullname == "" {
            self.showSnack(messages: "Enter Fullname")
        }
        else if sEmail == "" {
            self.showSnack(messages: "Enter Email Address")
        }
        else if sPassword == "" {
            self.showSnack(messages: "Enter Password")
        }
    
        else {
            ProgressHUDShow(text: "Creating Account...")
            
            FirebaseStoreManager.auth.createUser(withEmail: sEmail!, password: sPassword!) { result, error in
                self.ProgressHUDHide()
                if let error = error {
                   
                    self.handleError(error)
                }
                else {
                    let userModel = UserModel()
                    userModel.email = sEmail!
                    userModel.fullName = sFullname!
                    userModel.uid = FirebaseStoreManager.auth.currentUser!.uid
                    userModel.registredAt = Date()
                    userModel.regiType = "password"
                    
                    self.addUserData(userData: userModel)
                    
                }
                
            }
            
        }
        
    }
    
    @objc func loginWithGoogleBtnClicked() {
        self.loginWithGoogle()
    }
    
    @objc func loginWithAppleBtnClicked(){
     
        self.startSignInWithAppleFlow()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    

    
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        // authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
   
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
}

extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


extension SignUpViewController : ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            var displayName = "KnectWise"
           
            
            if let fullName = appleIDCredential.fullName {
                if let firstName = fullName.givenName {
                    displayName = firstName
                }
                if let lastName = fullName.familyName {
                    displayName = "\(displayName) \(lastName)"
                }
            }
            
            authWithFirebase(credential: credential, type: "apple",displayName: displayName)
            
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        
        print("Sign in with Apple errored: \(error)")
    }
    
}
