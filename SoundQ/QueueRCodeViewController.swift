//
//  QueueRCodeViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 6/2/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit

class QueueRCodeViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}