//
//  Connection.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Connection: NSObject, GCDAsyncSocketDelegate
{
    let filterChain:FilterChain;
    let socket:GCDAsyncSocket
    let requestData:NSMutableData
    var customValues = Dictionary<String, Any>()
    
    var request:Request?
    var response:Response?
    var expectedContentLength:Int?
    var didSendResponse = false;
    
    init(socket:GCDAsyncSocket, filterChain:FilterChain)
    {
        self.socket = socket
        self.filterChain = filterChain
        requestData = NSMutableData()
        super.init()
        
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
            response = Response();
            
            filterChain.processFilters(self)
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
        socket.delegate = nil
        socket.disconnect()
    }
}


