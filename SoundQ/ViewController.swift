//
//  ViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 4/24/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import Soundcloud
import Alamofire
import Firebase

class ViewController: UIViewController {
    
    var user: User?

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
        Session.login(self, completion:{ result in
            self.loadUser()
        })
    }
    
    func loadUser() {
        Soundcloud.session?.me({ result in
            self.user = result.response.result
            
            if self.user != nil {
                self.loadHomeViewController()
                self.authenticateWithFirebase()
            }
        })
    }
    
    func authenticateWithFirebase() {
        let ref = Firebase(url: "https://soundq.firebaseio.com/")
        
        Alamofire.request(.GET, "http://sound-q.herokuapp.com/gettoken/", parameters: ["uid": user!.identifier, "auth_data": ""]).responseString { response in
            
            if let auth_token = response.result.value {
                ref.authWithCustomToken(auth_token, withCompletionBlock: { error, authData in
                    if error == nil {
                        self.updateUserInFirebase()
                    }
                })
            }
        }
    }
    
    func updateUserInFirebase() {
        let userURL = "https://soundq.firebaseio.com/users/"+String(self.user!.identifier)
        let userRef = Firebase(url: userURL)
        
        userRef.observeSingleEventOfType(.Value, withBlock: { userSnapshot in
            userRef.childByAppendingPath("fullName").setValue(self.user!.fullname)
            if(!userSnapshot.hasChild("queues")) {
                userRef.childByAppendingPath("queues").setValue("null");
            }
        })
    }
    
    func loadHomeViewController() {
        let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("homeViewController") as! HomeViewController
        self.presentViewController(homeViewController, animated: true, completion: nil)
    }

}

