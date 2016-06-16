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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var user: User?
    var pressedQueue: Queue?
    var queueIdentifiers: [String] = []
    var queues: [Queue] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //load basic queue data from FireBase
        let userQueuesURL = "https://soundq.firebaseio.com/users/\(self.user!.identifier)/queues"
        let userQueuesRef = Firebase(url: userQueuesURL)
        
        //var userQueues: [String] = []
        queueIdentifiers = []
        queues = []
        
        userQueuesRef.observeSingleEventOfType(.Value, withBlock: { userQueuesSnapshot in
            for queue in userQueuesSnapshot.children {
                self.queueIdentifiers.append(queue.key)
                
                //if !self.queueIdentifiers.contains(queue.key) {
                //}
                let queueURL = "https://soundq.firebaseio.com/queues/\(queue.key)"
                let queueRef =  Firebase(url: queueURL)
                
                queueRef.observeSingleEventOfType(.Value, withBlock: { queueSnapshot in
                    let identifier = queue.key
                    let title = queueSnapshot.value.objectForKey("title") as! String
                    let owner = queueSnapshot.value.objectForKey("owner") as! Int
                    let coverArtPath = queueSnapshot.value.objectForKey("coverArt") as! String
                    
                    var newQueue = Queue(title: title, identifier: identifier, owner: owner)
                    newQueue.setCoverArtWithPath(coverArtPath)
                    self.queues.append(newQueue)
                    print(newQueue)
                    
                    if(self.queueIdentifiers.count == Int(userQueuesSnapshot.childrenCount)) {
                        self.setScrollView()
                        self.activityIndicator.stopAnimating()
                    }
                })
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColors()
        setNavigationBar()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.color = UIColor.whiteColor()
        activityIndicator.transform = CGAffineTransformMakeScale(2, 2);
        activityIndicator.startAnimating()
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
        
        let scrollingView = colorButtonsView(CGSizeMake(hsvHeight, hsvHeight), buttonCount: self.queues.count)
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
        
        if(buttonCount == 1) {
            //shift to center
            buttonPosition.x = horizontalScrollView.frame.size.width/2 - buttonSize.width/2
        }
        
        for i in 0...(buttonCount - 1)  {
            let button = configureQueueButtonAtIndex(i, size: buttonSize, position: buttonPosition)
            
            buttonPosition.x = buttonPosition.x + buttonIncrement
            
            //set background image
            var buttonImage = queues[i].coverArt
            buttonImage = Utilities().drawRectangleOnImage(buttonImage!)
            button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(HomeViewController.queuePressed(_:)), forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        
        return buttonView
    }
    
    func configureQueueButtonAtIndex(index: Int, size: CGSize, position: CGPoint) -> UIButton {
        let queueButton = UIButton(type: UIButtonType.Custom) as UIButton
        let currentQueue = queues[index]
        
        queueButton.accessibilityIdentifier = String(index)
        
        queueButton.frame.size = size
        queueButton.frame.origin = position
        queueButton.backgroundColor = UIColor.blackColor()
        queueButton.layer.cornerRadius = 5
        queueButton.layer.borderWidth = 2
        queueButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        queueButton.setTitle(currentQueue.title, forState: UIControlState.Normal)
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
        pressedQueue = queues[Int(sender.accessibilityIdentifier!)!]
        
        self.performSegueWithIdentifier("QueueSegue", sender: self)
    }
    
    func createQueue(title: String) {
        
        Alamofire.request(.GET, "http://sound-q.herokuapp.com/getqueuecode/", parameters: nil).responseString { response in
            
            let identifier = response.result.value!
            let owner: Int = self.user!.identifier
            let newQueue = Queue(title: title, identifier: identifier, owner: owner)
            
            self.storeQueueInFirebase(newQueue)
        }
        
        //store in Realm?
    }
    
    func storeQueueInFirebase(queue: Queue) {
        let queuesURL = "https://soundq.firebaseio.com/queues/"+queue.identifier
        let queuesRef = Firebase(url: queuesURL)
        
        queuesRef.observeSingleEventOfType(.Value, withBlock: { queueSnapshot in
            queuesRef.childByAppendingPath("title").setValue(queue.title)
            queuesRef.childByAppendingPath("owner").setValue(queue.owner)
            queuesRef.childByAppendingPath("tracks").setValue("")
            queuesRef.childByAppendingPath("coverArt").setValue("")
        })
        
        let userQueuesURL = "https://soundq.firebaseio.com/users/\(queue.owner)/queues"
        let userQueuesRef = Firebase(url: userQueuesURL)
        
        userQueuesRef.observeSingleEventOfType(.Value, withBlock: { userSnapshot in
            userQueuesRef.childByAppendingPath(String(queue.identifier)).setValue(queue.identifier)
        })
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