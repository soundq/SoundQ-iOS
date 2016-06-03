//
//  JoinQueueViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 6/2/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import SwiftQRCode

class JoinQueueViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    let scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        prepareScanner()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        scanner.startScan()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        dismissViewController()
    }
    
    func dismissViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func prepareScanner() {
        scanner.prepareScan(self.view) { code -> () in
            print(code)
            //add user to queue with id code
            self.dismissViewController()
        }
        scanner.scanFrame = self.view.bounds
    }
}
