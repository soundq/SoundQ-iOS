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
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    
    var hsvHeight: CGFloat = 0
    
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
        
        for _ in 0...(buttonCount - 1)  {
            let button = UIButton(type: UIButtonType.Custom) as UIButton
            
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor.blackColor()
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.whiteColor().CGColor
            
            let buttonImage = UIImage(named: "album")
            //let buttonImageSize = CGSizeMake(hsvHeight, hsvHeight)
            //buttonImage = Utilities().resizeImage(buttonImage!, newSize: buttonImageSize)
            button.setImage(buttonImage, forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(HomeViewController.queuePressed(_:)), forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        
        return buttonView
    }
    
    func queuePressed(sender:UIButton){
        //print(sender)
    }
}