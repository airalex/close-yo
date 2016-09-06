//
//  TableViewController.swift
//  CloseYo
//
//  Created by Alexander Juda on 06/09/16.
//
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomieCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Homie!"
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "nearby homies"
    }
}

