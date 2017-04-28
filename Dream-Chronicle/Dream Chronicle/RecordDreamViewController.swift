//
//  RecordDreamViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/13/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

protocol ReloadTableData: class {
    func reloadTable()
}

class RecordDreamViewController: UIViewController, DataEnteredDelegate {

    @IBOutlet weak var dreamTextField: UITextView!
    weak var delegate: ReloadTableData?
    var prepopulateDream = ""
    var prepopulateArt = ""
    var prepopulateDate = ""
    var theSender = "" //What sent you to this view
    var sentArt = ""

    
    @IBAction func Back(_ sender: UIBarButtonItem) {
     dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveData(_ sender: UIBarButtonItem) {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        if self.theSender != "" {
            let username = currentUser.theUser
            let dreamText = dreamTextField.text!
            
            ref.child("dreams/" + username + "/" + prepopulateDate + "/dreamtext").setValue(dreamText)
            if sentArt != "" {
                ref.child("images/" + username + "/" + prepopulateDate + "/artImage").setValue(sentArt)
            }
            
            dismiss(animated: true, completion: nil)
            delegate?.reloadTable()
        }
        else {
            let username = currentUser.theUser
            let dreamText = dreamTextField.text!
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let result = formatter.string(from: date)
            
            ref.child("dreams/" + username + "/" + result + "/dreamtext").setValue(dreamText)
            if sentArt != "" {
                ref.child("images/" + username + "/" + result + "/artImage").setValue(sentArt)
            }
            
            print("saved")
            dismiss(animated: true, completion: nil)
        }
    
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (prepopulateDream != "") {
            dreamTextField.text! = prepopulateDream
        }
        print(prepopulateArt)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toArtView" {
            let theArtView = segue.destination as! AddArtViewController
            theArtView.delegate = self
            
            if self.theSender == "dreamList" {
                theArtView.prepopulateArt = self.prepopulateArt
            }
            //Will overwrite previous statement, but this is fine.
            if self.sentArt != "" {
                theArtView.prepopulateArt = self.sentArt
            }
                
        }
    }

    func userDidMakeArt(info: String) {
        self.sentArt = info
    }
    
    
    
    
}
