//
//  RSTableViewController.swift
//  RACSwift-SearchBar
//
//  Created by Azri Jamil on 11/12/14.
//  Copyright (c) 2014 Nematix System. All rights reserved.
//

import UIKit


class RSTableViewController: UITableViewController {
    var searchTexts: [String] = ["Kuala Terengganu", "Setiu","Marang","Besut"]
    var searchResults: [String] = []
    var isSearching: Bool = false

    
    //
    // View Did Load
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        RAC(self,"searchResults") <~ self.rac_liftSelector(Selector("search:"), withSignalsFromArray: [self.searchDisplayController!.searchBar.rac_textSignal()])
        RAC(self,"isSearching") <~ self.searchDisplayController!.rac_ActiveSignal().doNext{ _ in NSLog("Searching..") }
    }

    
    //
    // Search Text
    //
    func search(searchText:String) -> [String] {
        return self.searchTexts.filter{
            return $0.lowercaseString.rangeOfString(searchText) != nil
        }
    }
    
    
    //
    // Section Count
    //
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    //
    // Row Count
    //
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.isSearching) {
            return self.searchResults.count;
        } else {
            return self.searchTexts.count;
        }
    }

    
    //
    // Row At Index
    //
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel.text = self.isSearching ? self.searchResults[indexPath.row] : self.searchTexts[indexPath.row]

        return cell!
    }
        
}
