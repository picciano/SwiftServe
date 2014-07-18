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
    let requestData = NSMutableData()
    var request:Request?
    var expectedContentLength:Int?
    
    init(socket:GCDAsyncSocket)
    {
        self.socket = socket
        socket.delegate = self
        println("Connection initialized.")
        
        socket.readDataWithTimeout(10, tag: 0)
    }
    
    func socket(socket:GCDAsyncSocket!, didReadData data:NSData!, withTag:Int)
    {
        if !request
        {
            request = Request(data: data)
            let contentLength:String? = request!.headers["Content-Length"]
            
            expectedContentLength = contentLength ? contentLength!.toInt() : 0
            
            println("headers: \(request!.headers)")
            println("request method: \(request!.HTTPMethod)")
            println("request url: \(request!.URL)")
            println("request body: \(request!.bodyData)")
            println("request user agent: \(request!.userAgent)")
        }
        else
        {
            requestData.appendData(data)
        }
        
        if requestData.length == expectedContentLength
        {
            request!.appendRequestData(requestData)
            // notify server???
        }
        else
        {
            socket.readDataWithTimeout(10, tag: 0)
        }
    }
}


