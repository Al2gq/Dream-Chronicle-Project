//
//  MenuViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/23/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var cameHereFrom = ""
    
    @IBOutlet weak var introText: UILabel!
    var loggedIn = false
    
    @IBAction func signOut(_ sender: Any) {
        currentUser.theUser = "none"
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "toDreamView" {
                if loggedIn != true {
                    return false
                }
            }
            if ident == "toDreamPlaylist" {
                if loggedIn != true {
                    return false
                }
            }
            if ident == "toSleepPlaylist" {
                if loggedIn != true {
                    return false
                }
            }
            if ident == "loggingOut" {
                if loggedIn != true {
                    return false
                }
            }
            
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentUser.theUser == "none" {
            introText.text = "You are not logged in. Buttons locked."
        }
        else {
            loggedIn = true
            introText.text = "Welcome, " + currentUser.theUser
        }
        
               
        
        //Ask how to fix window hierarchy issues, non pop ups without modal present
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if cameHereFrom == "loggingIn" {
            let alert = UIAlertController(title: "Logged in", message: "You have been successfully logged in.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if cameHereFrom == "creatingNewUser" {
            let alert = UIAlertController(title: "User Created", message: "Your profile has been created.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Get dreaming!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //        else if cameHereFrom == "editingDream" {
        //            let alert = UIAlertController(title: "Saved", message: "Your dream has been successfully edited.", preferredStyle: UIAlertControllerStyle.alert)
        //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //            self.present(alert, animated: true, completion: nil)
        //        }
        //        else if cameHereFrom == "recordingDream" {
        //            let alert = UIAlertController(title: "Saved", message: "Your dream has been successfully recorded.", preferredStyle: UIAlertControllerStyle.alert)
        //            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //            self.present(alert, animated: true, completion: nil)
        //        }
        
        cameHereFrom = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
