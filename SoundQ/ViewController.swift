//
//  ViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 4/24/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import Soundcloud

class ViewController: UIViewController {

    @IBOutlet weak var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background image
        let backgroundImage = UIImage(named: "login_background")
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = backgroundImage
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectButtonPressed(sender: AnyObject) {
        Session.login(self, completion: { result in })
    }
    

}

