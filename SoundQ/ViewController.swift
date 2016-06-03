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
import RealmSwift
import Firebase

class ViewController: UIViewController {
    
    var user: User?
    var userIsLoggedIn: Bool = false

    @IBOutlet weak var connectButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let ref = Firebase(url: "https://soundq.firebaseio.com")
        let realm = try! Realm()
        
        userIsLoggedIn = (ref.authData != nil)
        if userIsLoggedIn {
            let realmUser = realm.objects(RealmUser).first
            if realmUser != nil {
                connectButton.hidden = true
                user = User(fromRealmUser: realmUser!)
                print(user)
            } else {
                userIsLoggedIn = false;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
    
        //set background image
        let backgroundImage = UIImage(named: "login_background")
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = backgroundImage
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(userIsLoggedIn) {
            loadHomeViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "HomeSegue") {
            self.navigationController?.navigationBarHidden = false;
            
            let nextViewController = segue.destinationViewController as! HomeViewController
            nextViewController.user = self.user
        }
    }

    @IBAction func connectButtonPressed(sender: AnyObject) {
        hideStatusBar()
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
                self.storeUser()
            }
        })
    }
    
    func storeUser() {
        let realmUser = RealmUser(fromUser: user!)
        let realm = try! Realm()
        
        //get older versions of users stored with same ID
        //let otherRealmUsers = realm.objects(RealmUser).filter("identifier == \(user?.identifier)")
        
        try! realm.write {
            //realm.delete(otherRealmUsers)
            realm.deleteAll()
            realm.add(realmUser)
        }
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
        self.performSegueWithIdentifier("HomeSegue", sender: self)
    }
    
    func hideStatusBar() {
        UIApplication.sharedApplication().statusBarHidden = true
    }

}

