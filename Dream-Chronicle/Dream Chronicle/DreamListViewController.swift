//
//  DreamListViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/23/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

struct dreamFile {
    var dreamText = ""
    var dreamArt = ""
    var dreamDate = ""
}

class DreamListViewController: UITableViewController, ReloadTableData  {

    var dream: Int!
    var dreamList = [dreamFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDatabase()
        
    }
    

    func loadDatabase() {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        ref.child("dreams/").child(currentUser.theUser).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [FIRDataSnapshot]{
                var theDreamFile = dreamFile()
                
                let value = child.value! as! NSDictionary
                theDreamFile.dreamText = value["dreamtext"] as! String
                
                let dateAndTime = child.key
                theDreamFile.dreamDate = dateAndTime
                
                ref.child("images/").child(currentUser.theUser).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(dateAndTime) {
                        ref.child("images/").child(currentUser.theUser).child(dateAndTime).observeSingleEvent(of: .value, with: { (snapshot) in
                            for artChild in snapshot.children.allObjects as! [FIRDataSnapshot] {
                                //print(artChild.value!)
                                //print(artChild)
                                //let artValue = artChild.value! as! NSDictionary
                                theDreamFile.dreamArt = artChild.value! as! String
                                //print(theDreamFile.dreamArt)
                                self.dreamList.append(theDreamFile)
                                self.dreamList.sort(by: {$0.0.dreamDate > $0.1.dreamDate})
                                self.tableView.reloadData()
                            }
                        })
                    }
                    else {
                        self.dreamList.append(theDreamFile)
                        self.tableView.reloadData()
                    }
                })
                
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ref: FIRDatabaseReference!
        ref = FIRDatabase.database().reference()
        
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CellID")

        //Ask why this sometimes is crashing if brought up repeatedly- something loading too fast?
        cell?.textLabel?.text = dreamList[indexPath.row].dreamDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(dreamList.count)
        return dreamList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dream = indexPath.row
        performSegue(withIdentifier: "MoveToDreamView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? DreamListViewController == self) {
            let recordDreamView = segue.destination as! RecordDreamViewController
            recordDreamView.prepopulateDream = dreamList[dream].dreamText
            recordDreamView.prepopulateArt = dreamList[dream].dreamArt
            //print(dreamList[dream])
            recordDreamView.prepopulateDate = dreamList[dream].dreamDate
            recordDreamView.theSender = "dreamList"
            recordDreamView.delegate = self
        }
    }
   
    func reloadTable() {
//        self.loadDatabase()
//        self.tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    
}
