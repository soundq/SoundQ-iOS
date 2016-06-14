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
        
        let realm = try! Realm()
        
        FIRAuth.auth()!.addAuthStateDidChangeListener() { (auth, firebaseUser) in
            if let firebaseUser = firebaseUser {
                let realmUser = realm.objects(RealmUser).filter("identifier == %@", firebaseUser.uid).first //where id = firebaseUser.id
                if realmUser != nil {
                    self.userIsLoggedIn = true
                    self.connectButton.hidden = true
                    self.user = User(fromRealmUser: realmUser!)
                    print(self.user)
                } else {
                    self.userIsLoggedIn = false;
                }
            }
        }
        
        //try! FIRAuth.auth()!.signOut()
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
        Alamofire.request(.GET, "http://sound-q.herokuapp.com/gettoken/", parameters: ["uid": user!.identifier, "auth_data": ""]).responseString { response in
            
            if let auth_token = response.result.value {
                FIRAuth.auth()!.signInWithCustomToken(auth_token, completion: { firebaseUser, error in
                    if let error = error {
                        print("sign in failed: "+error.localizedDescription)
                    } else {
                        self.updateUserInFirebase()
                    }
                })
            }
        }
    }
    
    func updateUserInFirebase() {
        let userRef = FIRDatabase.database().reference().child("users/"+String(self.user!.identifier))
        
        userRef.observeSingleEventOfType(.Value, withBlock: { userSnapshot in
            userRef.child("fullName").setValue(self.user!.fullname)
            if(!userSnapshot.hasChild("queues")) {
                userRef.child("queues").setValue("null");
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

