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
    @IBOutlet weak var QRCodeImageView: UIImageView!
    @IBOutlet weak var queueCodeLabel: UILabel!
    
    var QRCodeImage: UIImage?
    var queueCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        QRCodeImageView.image = QRCodeImage
        queueCodeLabel.text = queueCode
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}