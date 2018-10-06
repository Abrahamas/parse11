//
//  RegisterViewController.swift
//  Parse1
//
//  Created by Mac on 7/13/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var username2Field: UITextField!
    
    @IBOutlet weak var email2FIield: UITextField!
    
    
    @IBOutlet weak var password2Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func register() {
        // initialize a user object
        let newUser = PFUser()
        // set user properties
        newUser.username = username2Field.text
        newUser.password = password2Field.text
        newUser.email = email2FIield.text
        
        if (newUser.username?.isEmpty)! && (newUser.password?.isEmpty)! && (newUser.email?.isEmpty)!{
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print("User sign in failed: \(error.localizedDescription)")
                } else {
                    print("User sign in successfully")
                     self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }

    @IBAction func onRegister(_ sender: Any) {
        register()
    }
    

}

