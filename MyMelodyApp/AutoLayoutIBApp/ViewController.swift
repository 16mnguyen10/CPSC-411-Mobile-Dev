//
//  ViewController.swift
//  AutoLayoutIBApp
//
//  Created by Michael Nguyen on 10/19/21.
//  Copyright © 2021 Michael Nguyen. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    @IBOutlet var songName : UITextField!
    @IBOutlet var outputTesting : UILabel!
    
    var data = MelodyRepository.get()
    var song : Song!
    
    @IBAction func add(_ sender: UIButton) {
        let sn = songName.text!
        
        data.createSong(stObj: Song(sn))        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
