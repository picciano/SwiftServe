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
            
            let filterChain = FilterChain();
            
            let logging:Logging = Logging(request: request!, response: response!)
            filterChain.add(logging)
            
            let errorPage:ErrorPage = ErrorPage(request: request!, response: response!)
            filterChain.add(errorPage)
            
            let nothing:Nothing = Nothing(request: request!, response: response!)
            filterChain.add(nothing)
            
            filterChain.processFilters()
            
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


