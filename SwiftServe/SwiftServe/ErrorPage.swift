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
            + "<p>The request \(requestString(connection)) failed.</p>"
            + "<hr><address>\(appName)/\(version) (MacOSX) at \(host)</address></body></html>"
        
        var messageData = message.bridgeToObjectiveC().dataUsingEncoding(NSUTF8StringEncoding)
        connection.response!.data.appendData(messageData)
    }
    
    func requestString(connection: Connection) -> String
    {
        let method = connection.request!.HTTPMethod
        let path = connection.request!.URL.path
        let version = connection.request!.version
        let host = connection.socket.connectedHost
        
        let request = "\"\(method) \(path) \(version)\" from \(host)"
        return request
    }
}