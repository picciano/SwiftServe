//
//  Request.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Request:Printable
{
    let message:CFHTTPMessage
    var headers = Dictionary<String, String>()
    
    init(data:NSData)
    {
        message = CFHTTPMessageCreateEmpty(nil, 1).takeRetainedValue()
        CFHTTPMessageAppendBytes(message, data.byteDataAsUInt8(), data.length)
        parseHeaders()
    }
    
    func parseHeaders()
    {
        let headersNSDictionary:NSDictionary = CFHTTPMessageCopyAllHeaderFields(message).takeRetainedValue()
        
        for (key : AnyObject, value : AnyObject) in headersNSDictionary
        {
            headers[key as String] = value as? String
            //            println("\(key): \(value)")
        }
    }
    
    func appendRequestData(data:NSData)
    {
        CFHTTPMessageAppendBytes(message, data.byteDataAsUInt8(), data.length)
    }
    
    var httpMethod:String
    {
        return CFHTTPMessageCopyRequestMethod(message).takeRetainedValue()
    }
    
    var url:NSURL
    {
        return CFHTTPMessageCopyRequestURL(message).takeRetainedValue()
    }
    
    var version:String
    {
        return CFHTTPMessageCopyVersion(message).takeRetainedValue()
    }
    
    var data:NSData
    {
        return CFHTTPMessageCopyBody(message).takeRetainedValue()
    }
    
    func value(forHeaderKey key:HeaderKey) -> String?
    {
        return headers[key.toRaw()];
    }
    
    var description:String
    {
        let result = httpMethod + " " + url.path + " " + version
        return result
    }
}