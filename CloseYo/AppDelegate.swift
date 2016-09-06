//
//  AppDelegate.swift
//  CloseYo
//
//  Created by Alexander Juda on 06/09/16.
//
//

import UIKit
import Swifter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let server = Swifter.HttpServer()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
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
        
        return true
    }

}

