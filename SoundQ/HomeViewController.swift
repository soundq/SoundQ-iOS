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
        
        self.view.backgroundColor = UIColor.blackColor()
        setNavigationBar()
        setScrollView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setScrollView() {
        let scrollingView = colorButtonsView(CGSizeMake(100.0,50.0), buttonCount: 10)
        horizontalScrollView.contentSize = scrollingView.frame.size
        horizontalScrollView.addSubview(scrollingView)
        horizontalScrollView.showsHorizontalScrollIndicator = true
        horizontalScrollView.indicatorStyle = .Default
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
    
    func colorButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        //creates color buttons in a UIView
        let buttonView = UIView()
        
        buttonView.backgroundColor = UIColor.blackColor()
        buttonView.frame.origin = CGPointMake(0,0)
        
        let padding = CGSizeMake(10, 10)
        let buttonViewSize = CGSizeMake((buttonSize.width + padding.width) * CGFloat(buttonCount), buttonSize.height +  2.0 * padding.height)
        buttonView.frame.size = buttonViewSize
        
        //add buttons to the view
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
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
            button.addTarget(self, action: #selector(HomeViewController.colorButtonPressed(_:)), forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        
        return buttonView
    }
    
    func colorButtonPressed(sender:UIButton){
        horizontalScrollView.backgroundColor = sender.backgroundColor
    }
}