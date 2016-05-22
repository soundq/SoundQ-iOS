//
//  HomeViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/10/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    var hsvHeight: CGFloat = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //load queues from FireBase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColors()
        setNavigationBar()
        setScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBackgroundColors() {
        horizontalScrollView.backgroundColor = UIColor.blackColor()
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    func setScrollView() {
        hsvHeight = horizontalScrollView.frame.size.height
        
        let scrollingView = colorButtonsView(CGSizeMake(hsvHeight * 1.4, hsvHeight * 1.4), buttonCount: 6)
        horizontalScrollView.contentSize = CGSizeMake(scrollingView.frame.size.width, 1.0)
        horizontalScrollView.addSubview(scrollingView)
        horizontalScrollView.showsHorizontalScrollIndicator = false
        horizontalScrollView.indicatorStyle = .Default
    }
    
    func setNavigationBar() {
        let textAttributes = [ NSForegroundColorAttributeName: UIColor.whiteColor() ]
        UIApplication.sharedApplication().statusBarHidden = false
        self.title = "SoundQ"
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func colorButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        //creates color buttons in a UIView
        let buttonView = UIView()
        
        buttonView.frame.origin = CGPointMake(0,0)
        let padding = CGSizeMake(10, 10)
        let buttonViewSize = CGSizeMake((buttonSize.width + padding.width) * CGFloat(buttonCount), buttonSize.height)
        buttonView.frame.size = buttonViewSize
        buttonView.backgroundColor = UIColor.blackColor()
        
        //add buttons to the view
        var buttonPosition = CGPointMake(padding.width * 0.5, 0)
        let buttonIncrement = buttonSize.width + padding.width
        
        for i in 0...(buttonCount - 1)  {
            let button = configureQueueButtonWithIdentifier(String(i), size: buttonSize, position: buttonPosition)
            
            buttonPosition.x = buttonPosition.x + buttonIncrement
            
            //set background image
            var buttonImage = UIImage(named: "album")
            buttonImage = Utilities().drawRectangleOnImage(buttonImage!)
            button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(HomeViewController.queuePressed(_:)), forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        
        return buttonView
    }
    
    func configureQueueButtonWithIdentifier(id: String, size: CGSize, position: CGPoint) -> UIButton {
        let queueButton = UIButton(type: UIButtonType.Custom) as UIButton
        
        queueButton.accessibilityIdentifier = id
        
        queueButton.frame.size = size
        queueButton.frame.origin = position
        queueButton.backgroundColor = UIColor.blackColor()
        queueButton.layer.cornerRadius = 5
        queueButton.layer.borderWidth = 2
        queueButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        queueButton.setTitle("Nishil's Queue", forState: UIControlState.Normal)
        queueButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        return queueButton
    }

    func queuePressed(sender: UIButton){
        let queueIdentifier = sender.accessibilityIdentifier!
        print("button id: \(queueIdentifier)")
        
        self.performSegueWithIdentifier("QueueSegue", sender: self)
    }
    
    @IBAction func createQueuePressed(sender: UIButton) {
        //let alert = UIAlertController(title: "Create Queue", message: "Enter a title for your queue:", preferredStyle: UIAlertControllerStyle.)
        //show alert asking for Queue Name
    }
    
}