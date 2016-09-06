//
//  TableViewController.swift
//  CloseYo
//
//  Created by Alexander Juda on 06/09/16.
//
//

import UIKit
import Swifter

class TableViewController: UITableViewController {
    
    let server = HttpServer()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        server["/yo"] = { (request) in
            
            // extract sender from query params
            let sender = request.queryParams.filter({ $0.0 == "sender"}).first?.1 ?? "unknown"
            
            // show alrt
            dispatch_async(dispatch_get_main_queue()) {
                UIAlertView(title: "Yo", message: "from " + sender, delegate: nil, cancelButtonTitle: "OK").show()
            }
            
            // return confirmation
            return HttpResponse.OK(HttpResponseBody.Json(["yo" : sender]))
        }
        
        do {
            try server.start()
        } catch {
            print(error)
        }
    }
}

