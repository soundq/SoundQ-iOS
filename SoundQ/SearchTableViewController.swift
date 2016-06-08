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
        return searchResults.count == 0 ? 0 : searchResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath) as! SearchResultTableViewCell
        cell.titleLabel.text = searchResults[indexPath.row].title
        cell.artistLabel.text = searchResults[indexPath.row].createdBy.username
        
        let coverArtPath = searchResults[indexPath.row].artworkImageURL.smallURL?.absoluteString
        Alamofire.request(.GET, coverArtPath!).responseImage { response in
            if let image = response.result.value {
                cell.coverArt.image = image
            }
        }
        
        cell.backgroundColor = UIColor.clearColor()
        cell.coverArt.image = UIImage(named: "album")
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let queryOptions: [SearchQueryOptions] = [ .QueryString(searchText!) ]
        
        if(searchText!.characters.count > 0) {
            Track.search(queryOptions, completion: { result in
                self.searchResults = result.response.result!
                print("COUNT \(self.searchResults.count)")
            })
        }
        self.tableView.reloadData()
    }
    
    
}
