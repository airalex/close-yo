//
//  Communicator.swift
//  CloseYo
//
//  Created by Alexander Juda on 06/09/16.
//
//

import Foundation
import Swifter

class Communicator {
    
    let server = Swifter.HttpServer()
    
    func startListening(yoHeardBlock: (String) -> ()) {
        server["/yo"] = { (request) in
            
            // extract sender from query params
            let sender = request.queryParams.filter({ $0.0 == "sender"}).first?.1 ?? "unknown"
            
            yoHeardBlock(sender)
            
            // return confirmation
            return HttpResponse.OK(HttpResponseBody.Json(["yo" : sender]))
        }
        
        do {
            try server.start()
        } catch {
            print(error)
        }
    }
    
    func sayYo(homieHostName hostName: String, myName: String) {
        let url = NSURL(string: "http://\(hostName):8080/yo?sender=\(myName)")!
        NSURLSession.sharedSession().dataTaskWithURL(url).resume()
    }
}