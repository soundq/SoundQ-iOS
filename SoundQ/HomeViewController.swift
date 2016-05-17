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
        let scrollingView = colorButtonsView(CGSizeMake(horizontalScrollView.frame.size.height * 1.5,horizontalScrollView.frame.size.height * 1.5), buttonCount: 6)
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
        let hueIncrement = 1.0 / CGFloat(buttonCount)
        var newHue = hueIncrement
        
        for _ in 0...(buttonCount - 1)  {
            let button = UIButton(type: UIButtonType.Custom) as UIButton
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor(hue: newHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            newHue = newHue + hueIncrement
            button.addTarget(self, action: #selector(HomeViewController.queuePressed(_:)), forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        
        return buttonView
    }
    
    func queuePressed(sender:UIButton){
        //print(sender)
    }
}