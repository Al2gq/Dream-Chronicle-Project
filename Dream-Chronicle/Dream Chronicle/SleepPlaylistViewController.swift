//
//  SleepPlaylistViewController.swift
//  Dream Chronicle
//
//  Created by Austin Luk on 4/15/17.
//  Copyright © 2017 Austin Luk. All rights reserved.
//

import UIKit
import AVFoundation

class SleepPlaylistViewController: UITableViewController {

    var track: Int!
    var names: [String] = ["Binaural Beats", "Lucid Dream ASMR", "Lucid Dream Meditation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "CellID")
        cell?.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        track = indexPath.row
        performSegue(withIdentifier: "MoveToAudioPlayer", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? SleepPlaylistViewController == self) {
            let audioPlayerVC = segue.destination as! AudioPlayerVC
            audioPlayerVC.trackID = track
            audioPlayerVC.trackName = names[track]
        }
        
    }

}
