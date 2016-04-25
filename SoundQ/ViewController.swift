//
//  ViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 4/24/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

