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
    override func processResponse(connection:Connection)
    {
        if connection.response!.data.length > 0
        {
            // there is already response data (perhaps JSON?), just return
            return
        }
        
        switch connection.response!.statusCode.code {
        case 0...199, 300...599:
            sendErrorPage(connection)
            
        default:
            break
        }
    }
    
    func sendErrorPage(connection:Connection)
    {
        let appName = NSBundle.mainBundle().infoDictionary.objectForKey(kCFBundleNameKey) as String
        let version = NSBundle.mainBundle().infoDictionary.objectForKey("CFBundleShortVersionString") as String
        let host = connection.request!.value(forHeaderKey: HeaderKey.Host)
        
        let message = "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">"
            + "<html><head><title>\(connection.response!.statusCode.code) \(connection.response!.statusCode.description)</title></head>"
            + "<body><h1>\(connection.response!.statusCode.description)</h1>"
            + "<p>The request \"\(connection.request!)\" from \(connection.socket.connectedHost) failed.</p>"
            + "<hr><address>\(appName)/\(version) (MacOSX) at \(host)</address></body></html>"
        
        var messageData = message.bridgeToObjectiveC().dataUsingEncoding(NSUTF8StringEncoding)
        connection.response!.data.appendData(messageData)
    }
}