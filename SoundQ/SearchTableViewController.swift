//
//  SearchTableViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 6/7/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit

class SearchTableViewController : UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Songs"
        self.tableView.backgroundColor = UIColor.blackColor()
        
        setBackButton()
        setSearchController()
    }
    
    func setBackButton() {
        let newBackButton = UIBarButtonItem()
        newBackButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = newBackButton
    }
    
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = UIColor.blackColor()
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
    }
    
    
}
