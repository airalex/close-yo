//
//  TableViewController.swift
//  CloseYo
//
//  Created by Alexander Juda on 06/09/16.
//
//

import UIKit
import Servus

class TableViewController: UITableViewController {
    
    let explorer = Servus.Explorer(identifier: NSUUID().UUIDString, appName: "CloseYo")
    let communicator = Communicator()
    
    var peers: [Servus.Peer] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        explorer.delegate = self
        explorer.startExploring()
        
        communicator.startListening { (sender) in
            dispatch_async(dispatch_get_main_queue()) {
                UIAlertView(title: "Yo!", message: "from " + sender, delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    // MARK: UITableViewDataSource
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomieCell", forIndexPath: indexPath)
        
        let peer = peers[indexPath.row]
        cell.textLabel?.text = peer.hostname ?? "unknown (\(peer))"
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "nearby homies"
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let homieHostname = peers[indexPath.row].hostname else {
            return
        }
        
        let myName = explorer.identifier
        communicator.sayYo(homieHostName: homieHostname, myName: myName)
    }
}

// MARK: ExplorerDelegate
extension TableViewController: Servus.ExplorerDelegate {
    
    // no hostname yet
    func explorer(explorer: Servus.Explorer, didSpotPeer peer: Servus.Peer) {
        print(#function)
        peers.append(peer)
    }
    
    // hostname resolved
    func explorer(explorer: Servus.Explorer, didDeterminePeer peer: Servus.Peer) {
        print(#function)
        if let index = peers.indexOf({ $0.identifier == peer.identifier }) {
            peers.removeAtIndex(index)
        }
        
        peers.append(peer)
    }
    
    // disappeared
    func explorer(explorer: Servus.Explorer, didLosePeer peer: Servus.Peer) {
        print(#function)
        if let index = peers.indexOf({ $0.identifier == peer.identifier }) {
            peers.removeAtIndex(index)
        }
    }
    
}

