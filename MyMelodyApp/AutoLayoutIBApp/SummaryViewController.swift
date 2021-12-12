//
//  SummaryViewController.swift
//  AutoLayoutIBApp
//
//  Created by Michael Nguyen on 12/11/21.
//  Copyright © 2021 Michael Nguyen. All rights reserved.
//

import UIKit

class SummaryViewController : UITableViewController {
    
    @IBOutlet var tblView : UITableView!
    @IBOutlet var removeBtn : UIButton!
    
    var data = MelodyRepository.get()
    
    // Button to remove (Change title of the button)
    @IBAction func remove(_ sender: UIButton) {
        if tblView.isEditing {
            removeBtn.setTitle("DELETE", for: .normal)
            tblView.setEditing(false, animated: true)
        }
        else {
            removeBtn.setTitle("DONE", for: .normal)
            tblView.setEditing(true, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Get the amount of entities
        let cnt = data.getSong().count
        print("Number of entries: \(cnt)")
        return cnt
    }
    
    /*
    // Support conditional editing of table view
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Logic to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let row = indexPath.row
            tableView.beginUpdates()
            
            // Remove entry from Table View
            // songCol[row]?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Delete the record from Database
            let sObj = data.getSong()[row]
            data.deleteSong(sObj: sObj)
            
            tableView.endUpdates()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongSummaryCell", for: indexPath)
        let song = data.getSong()[indexPath.row]
        cell.textLabel?.text = song.song_name
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblView.reloadData()
    }
    
}
