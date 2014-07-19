//
//  ErrorPage.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class ErrorPage:Filter
{
    override func processResponse()
    {
        switch response.statusCode.code {
        case 0...199, 300...599:
            sendErrorPage()
            
        default:
            break
        }
    }
    
    func sendErrorPage()
    {
        let appName = NSBundle.mainBundle().infoDictionary.objectForKey(kCFBundleNameKey) as String
        let version = NSBundle.mainBundle().infoDictionary.objectForKey("CFBundleShortVersionString") as String
        let host = request.value(forHeaderKey: HeaderKey.Host)
        
        let message = "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">"
            + "<html><head><title>\(response.statusCode.code) \(response.statusCode.description)</title></head><body><h1>\(response.statusCode.description)</h1>"
            + "<p>The requested URL \(request.URL) failed.</p>"
            + "<hr><address>\(appName)/\(version) (MacOSX) at \(host)</address></body></html>"
        
        var messageData = message.bridgeToObjectiveC().dataUsingEncoding(NSUTF8StringEncoding)
        response.data.appendData(messageData)
    }
}