//
//  QueueViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/22/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import SwiftQRCode
import Soundcloud
import Firebase
import RealmSwift

class QueueViewController: UIViewController {
    
    var queue: Queue?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.title = queue?.title
        print("Tracks in Queue: \(queue?.tracks.count)")
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
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(presentQRCodeModal))
        let search = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(presentSearchModal))
        
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
    
    func addTracks(tracks: [Track]) {
        self.queue?.tracks += tracks
        
        let queueIdentifier = self.queue?.identifier
        //add to firebase
        let queueURL = "https://soundq.firebaseio.com/queues/\(queueIdentifier!)/tracks"
        let queueRef = Firebase(url: queueURL)
        
        queueRef.observeSingleEventOfType(.Value, withBlock: { queueSnapshot in
            for track in tracks {
                queueRef.childByAppendingPath(String(track.identifier)).setValue(NSDate().timeIntervalSince1970)
            }
        })
        
        //save to realm
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString)
        for track in tracks {
            print(track.identifier)
            let trackResult = realm.objects(RealmTrack.self).filter("identifier == \(track.identifier)")
            print(trackResult.count)
            if(trackResult.count == 0) {
                try! realm.write {
                    let realmTrack = RealmTrack(fromTrack: track)
                    realm.add(realmTrack)
                }
            }
        }
    }
    
    func presentQRCodeModal() {
        self.performSegueWithIdentifier("QRCodeSegue", sender: self)
    }
    
    func presentSearchModal() {
        self.performSegueWithIdentifier("SearchSegue", sender: self)
    }
    
}