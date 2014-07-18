//
//  Request.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Request
{
    let message:CFHTTPMessage
    let headersNSDictionary:NSDictionary
//    let CRLFData = "\r\n".dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
//    let CRLFCRLFData = "\r\n\r\n".dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
    
    var headers:Dictionary<String, String> = Dictionary<String, String>()
    
    enum HeaderKey:String
    {
        case UserAgent = "User-Agent"
        case Host = "Host"
        case Accept = "Accept"
        case AcceptLanguage = "Accept-Language"
        case Connection = "Connection"
        case AcceptEncoding = "AcceptEncoding"
    }
    
    init(data:NSData)
    {
        message = CFHTTPMessageCreateEmpty(nil, 1).takeRetainedValue()
        CFHTTPMessageAppendBytes(message, data.byteDataAsUInt8(), data.length)
        
        headersNSDictionary = CFHTTPMessageCopyAllHeaderFields(message).takeUnretainedValue()
        parseHeaders()
    }
    
    func appendRequestData(data:NSData)
    {
        CFHTTPMessageAppendBytes(message, data.byteDataAsUInt8(), data.length)
    }
    
    func parseHeaders()
    {
        for (key : AnyObject, value : AnyObject) in headersNSDictionary
        {
            headers[key as String] = value as? String
        }
        
        CFRelease(headersNSDictionary)
    }
    
    var HTTPMethod:String
    {
        return CFHTTPMessageCopyRequestMethod(message).takeUnretainedValue()
    }
    
    var URL:NSURL
    {
        return CFHTTPMessageCopyRequestURL(message).takeUnretainedValue()
    }
    
    var bodyData:NSData
    {
        return CFHTTPMessageCopyBody(message).takeUnretainedValue()
    }
    
    var userAgent:String?
    {
        return headers[HeaderKey.UserAgent.toRaw()]
    }
    
    deinit
    {
        CFRelease(message)
    }
}