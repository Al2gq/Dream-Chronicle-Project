//
//  LoginViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/19/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct currentUser {
    static var theUser = "none"
}

class LoginViewController: UIViewController {

    @IBOutlet weak var loginUsername: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var createUsername: UITextField!
    @IBOutlet weak var createPassword: UITextField!
    var login = false
    var loggingOrCreating = ""
    
    
    
    @IBAction func firebaseCreateUser(_ sender: Any) {
        let username = createUsername.text!
        let password = createPassword.text!
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.hasChild(username)) {
                print("We have that one")
                let alert = UIAlertController(title: "Invalid", message: "Username is already in use.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                self.login = true
                ref.child("users/" + username).setValue(password)
                currentUser.theUser = username
                print("You're in")
                self.loggingOrCreating = "creating"
                self.performSegue(withIdentifier: "successfulUserCreation", sender: self)
                //perform segue to menuview and pop up
            }
            
        })
        
        
    }
   
    @IBAction func firebaseLoginUser(_ sender: Any) {
        
        let username = loginUsername.text!
        let password = loginPassword.text!
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        ref.child("users/").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let firebaseUser = value?[username] as? String ?? ""
            if firebaseUser == password {
                self.login = true
            }
            
            if(self.login) {
                currentUser.theUser = username
                print("Good to go")
                print(username)
                self.loggingOrCreating = "logging"
                self.performSegue(withIdentifier: "successfulLogin", sender: self)
            }
            else {
                let alert = UIAlertController(title: "Invalid", message: "User/Password combination does not exist.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "successfulLogin" {
                if login != true {
                    return false
                }
            }
            if ident == "successfulUserCreation" {
                if login != true {
                    return false
                }
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? LoginViewController == self) {
            let theMenuView = segue.destination as! MenuViewController
            if self.loggingOrCreating == "logging" {
                theMenuView.cameHereFrom = "loggingIn"
            }
            else if self.loggingOrCreating == "creating"{
                theMenuView.cameHereFrom = "creatingNewUser"
            }
        }
    }

}
