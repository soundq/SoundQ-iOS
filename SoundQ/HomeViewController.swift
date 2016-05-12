//
//  HomeViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 5/10/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import Firebase
import ASHorizontalScrollView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var horizontalScrollView: ASHorizontalScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        setNavigationBar()
        //setScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setScrollView() {
        horizontalScrollView.leftMarginPx = 10
        horizontalScrollView.miniMarginPxBetweenItems = 0
        horizontalScrollView.miniAppearPxOfLastItem = 15
        let hsvHeight = horizontalScrollView.frame.size.height
        horizontalScrollView.uniformItemSize = CGSizeMake(hsvHeight, hsvHeight)
        
        horizontalScrollView.setItemsMarginOnce()
        for _ in 1...20 {
            let button = UIButton(frame: CGRectZero)
            button.backgroundColor = UIColor.orangeColor()
            horizontalScrollView.addItem(button)
        }
    }
    
    func setNavigationBar() {
        let textAttributes = [ NSForegroundColorAttributeName: UIColor.whiteColor() ]
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        self.title = "SoundQ"
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}