//
//  LoginViewController.swift
//  Parse1
//
//  Created by Mac on 7/12/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
      
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onSingin(_ sender: Any) {
        //register()
       // alert()
    }




    @IBAction func onLogin(_ sender: Any) {
        login()
        alert()
    }
    func login() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    func alert () {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        if (username.isEmpty) && (password.isEmpty) {
                    let alertController = UIAlertController(title: "Empty Username or Password", message: "Username or password cannot be empty. Must provide username for login", preferredStyle: .alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in
                    })
                    
                    alertController.addAction(okButton)
                    
                   self.present(alertController, animated: true)
                }
            }
    
    }
        




