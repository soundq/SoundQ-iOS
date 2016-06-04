//
//  HomeViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/10/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import Firebase
import Soundcloud
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    var user: User?
    var pressedQueue: Queue?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //load basic queue data from FireBase
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
        let hsvHeight = horizontalScrollView.frame.size.height
        
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
        
        //TODO: Back button not hid on first access to view controller
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
        
        queueButton.setTitle("Nishil Queue \(id)", forState: UIControlState.Normal)
        queueButton.titleLabel?.font = UIFont.systemFontOfSize(14.0)
        
        return queueButton
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "QueueSegue") {
            let nextViewController = segue.destinationViewController as! QueueViewController
            nextViewController.queue = pressedQueue
        }
    }

    func queuePressed(sender: UIButton){
        let queueTitle = sender.currentTitle!
        let queueIdentifier = sender.accessibilityIdentifier!
        pressedQueue = Queue(title: queueTitle, identifier: queueIdentifier)
        
        self.performSegueWithIdentifier("QueueSegue", sender: self)
    }
    
    func createQueue(title: String) {
        
        var identifier: String = ""
        let owner: Int = self.user!.identifier
        
        Alamofire.request(.GET, "http://sound-q.herokuapp.com/getqueuecode/", parameters: nil).responseString { response in
            
            identifier = response.result.value!
        }
        
        let newQueue = Queue(title: title, identifier: identifier, owner: owner)
        print(newQueue)
        //store in firebase and Realm?
    }
    
    @IBAction func createQueuePressed(sender: UIButton) {
        
        let alert = UIAlertController(title: "Create Queue", message: "Give it a name:", preferredStyle: .Alert)
        
        //configure alert
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "\(self.user!.username)'s Queue"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            //process results
            let textField = alert.textFields![0] as UITextField
            let newQueueTitle = textField.text!
            self.createQueue(newQueueTitle)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}