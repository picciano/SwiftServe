//
//  Response.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Response:Printable
{
    let data:NSMutableData
    var headers:Dictionary<String, String>
    var statusCode:StatusCode;
    
    init(statusCode:StatusCode = StatusCode.NOT_SET)
    {
        data = NSMutableData()
        
        self.statusCode = statusCode
        
        headers = Dictionary<String, String>()
        setValue("close", forHeaderKey: HeaderKey.Content)
    }
    
    var message:CFHTTPMessageRef
    {
        // Create the response object reference
        let message = CFHTTPMessageCreateResponse(nil, statusCode.code, "", kCFHTTPVersion1_1).takeUnretainedValue()
            
        // Set the content length
        CFHTTPMessageSetHeaderFieldValue(message, HeaderKey.ContentLength.toRaw() as NSString, "\(data.length)" as NSString);
            
        // Add the headers
        for (key, value) in headers
        {
            CFHTTPMessageSetHeaderFieldValue(message, key as NSString, value as NSString);
        }
            
        // Add the message body
        CFHTTPMessageSetBody(message, data)
            
        return message
    }
    
    var messageData:NSData
    {
    //TODO: collapse
        var dataRef = CFHTTPMessageCopySerializedMessage(message).takeUnretainedValue()
        return dataRef
    }
    
    func setValue(value:String?, forHeaderKey key:HeaderKey)
    {
        headers[key.toRaw()] = value;
    }
    
    func value(forHeaderKey key:HeaderKey) -> String?
    {
        return headers[key.toRaw()];
    }
    
    var description:String
    {
        return "\(statusCode.code) \(data.length)"
    }
}