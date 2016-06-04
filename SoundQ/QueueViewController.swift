//
//  QueueViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/22/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import SwiftQRCode

class QueueViewController: UIViewController {
    
    var queue: Queue?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.title = queue?.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        setNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    func setNavigationBar() {
        let textAttributes = [ NSForegroundColorAttributeName: UIColor.whiteColor() ]
        UIApplication.sharedApplication().statusBarHidden = false
        
        self.navigationItem.hidesBackButton = false
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(presentModal))
        let search = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(addTapped))
        
        self.navigationItem.rightBarButtonItems = [search, add]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "QRCodeSegue") {
            let queueCode: String = queue!.identifier
            let QRCodeImage = QRCode.generateImage(queueCode, avatarImage: nil)
            let nextViewController = segue.destinationViewController as! QueueRCodeViewController
            nextViewController.QRCodeImage = QRCodeImage
            nextViewController.queueCode = queueCode
        }
    }
    func presentModal() {
        self.performSegueWithIdentifier("QRCodeSegue", sender: self)
    }
    
    func addTapped() {
        
    }
    
}