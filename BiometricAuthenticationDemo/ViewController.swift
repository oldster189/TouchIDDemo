//
//  ViewController.swift
//  BiometricAuthenticationDemo
//
//  Created by itthipon wiwatthanasathit on 12/13/2560 BE.
//  Copyright © 2560 Dev7. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var mUsernameTF: UITextField!
    @IBOutlet weak var mPasswordTF: UITextField!
    @IBOutlet weak var mLoginBtn: UIButton!
    
    let usernameKey = "demo"
    let passwordKey = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mLoginBtn.layer.cornerRadius = 4
        
    }
    @IBAction func onClickVertifyTouchID(_ sender: Any) {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            // Device support authentication
            // Request dialog scan authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "กรุณายืนยันตัวตนของท่าน", reply: { (isSuccessfuly, error) in
                
                // Change values UI Main Thread
                DispatchQueue.main.async {
                    if isSuccessfuly {
                        // Business logic after authentication success
                        self.alertMessage("Status Vertify", "Authentication successfully!")
                    }else{
                        // Business logic after authentication not success
                        self.alertMessage("Status Vertify", "Authentication failed!")
                    }
                }
            })
        }else{
            // Device not support authentication
            alertMessage("Touch ID not available", "Your device is not configured for Touch ID.")
        }
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        if checkLogin(username: mUsernameTF.text!, password: mPasswordTF.text!) {
            alertMessage("", "Login successfully!")
        }else{
            alertMessage("", "Username or password incorrect!")
        }
    }
    
    func checkLogin(username: String, password: String) -> Bool {
        return username == usernameKey && password == passwordKey
    }
    
    func alertMessage(_ title:String, _ message:String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    }
    
}

