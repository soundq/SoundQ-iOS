//
//  SearchTableViewController.swift
//  SoundQ
//
//  Created by Nishil Shah on 6/7/16.
//  Copyright © 2016 Nishil Shah. All rights reserved.
//

import UIKit
import Soundcloud
import Alamofire
import AlamofireImage

class SearchTableViewController : UITableViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchResults: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Songs"
        self.tableView.backgroundColor = UIColor.blackColor()
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.separatorInset = UIEdgeInsetsZero
        self.tableView.allowsMultipleSelection = true;

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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        cell.track = searchResults[indexPath.row]
        cell.titleLabel.text = searchResults[indexPath.row].title
        cell.artistLabel.text = searchResults[indexPath.row].createdBy.username
        cell.coverArt.image = UIImage(named: "unknown_cover_art")
        
        let coverArtPath = searchResults[indexPath.row].artworkImageURL.largeURL?.absoluteString
        Alamofire.request(.GET, coverArtPath!).responseImage { response in
            if let image = response.result.value {
                cell.coverArt.image = image
            }
        }
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let queryOptions: [SearchQueryOptions] = [ .QueryString(searchText!) ]
        
        searchResults.removeAll(keepCapacity: false)
        
        if(searchText!.characters.count > 0) {
            Track.search(queryOptions, completion: { result in
                self.searchResults = result.response.result!
                self.tableView.reloadData()
            })
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
}
