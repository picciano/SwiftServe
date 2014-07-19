//
//  Connection.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Connection: GCDAsyncSocketDelegate
{
    let socket:GCDAsyncSocket
    let requestData:NSMutableData
    
    var request:Request?
    var response:Response?
    var expectedContentLength:Int?
    var didSendResponse = false;
    
    init(socket:GCDAsyncSocket)
    {
        self.socket = socket
        requestData = NSMutableData()
        println("Connection initialized.")
        
        socket.delegate = self
        socket.readDataWithTimeout(10, tag: 0)
    }
    
    func socket(socket:GCDAsyncSocket!, didReadData data:NSData!, withTag:Int)
    {
        if !request
        {
            request = Request(data: data)
            var contentLength:String? = request!.value(forHeaderKey: HeaderKey.ContentLength)
            expectedContentLength = contentLength ? contentLength!.toInt() : 0
        }
        else
        {
            requestData.appendData(data)
        }
        
        if requestData.length == expectedContentLength
        {
            request!.appendRequestData(requestData)
            
            let statusCode = StatusCode.NOT_IMPLEMENTED
            response = Response(statusCode: statusCode);
            
            // notify server??? start doing something...error for now
            let appName = NSBundle.mainBundle().infoDictionary.objectForKey(kCFBundleNameKey) as String
            let version = NSBundle.mainBundle().infoDictionary.objectForKey("CFBundleShortVersionString") as String
            let host = request!.value(forHeaderKey: HeaderKey.Host)
            
            let message = "<!DOCTYPE HTML PUBLIC \"-//IETF//DTD HTML 2.0//EN\">"
                + "<html><head><title>\(statusCode.code) \(statusCode.description)</title></head><body><h1>\(statusCode.description)</h1>"
                + "<p>The requested URL \(request!.URL) failed.</p>"
                + "<hr><address>\(appName)/\(version) (MacOSX) at \(host)</address></body></html>"
            
            var messageData = message.bridgeToObjectiveC().dataUsingEncoding(NSUTF8StringEncoding)
            response!.data.appendData(messageData)
            
            sendResponse()
        }
        else
        {
            socket.readDataWithTimeout(10, tag: 0)
        }
    }
    
    func sendResponse()
    {
        if didSendResponse
        {
            return;
        }
        
        didSendResponse = true;
        socket.writeData(response!.messageData, withTimeout: 5, tag: 0)
        socket.disconnect()
    }
}


