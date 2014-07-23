//
//  JSONSerialization.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/21/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

// TODO: class variable are not yet supported
let jsonRequestObjectKey = "JSONRequestObject"
let jsonResponseObjectKey = "JSONResponseObject"

extension Connection
    {
    func JSONRequestObject() -> NSDictionary?
    {
        let value:Any? = customValues[jsonRequestObjectKey]
        return value as? NSDictionary
    }
    
    func setJSONRequestObject(object:NSDictionary)
    {
        customValues[jsonRequestObjectKey] = object
    }
    
    func JSONResponseObject() -> NSDictionary?
    {
        let value:Any? = customValues[jsonResponseObjectKey]
        return value as? NSDictionary
    }
    
    func setJSONResponseObject(object:NSDictionary)
    {
        customValues[jsonResponseObjectKey] = object
    }
}

class JSONSerialization:Filter
{
    let options:NSJSONWritingOptions
    
    init (usePrettyPrint:Bool = false)
    {
        if usePrettyPrint
        {
            options = NSJSONWritingOptions.PrettyPrinted
        }
        else
        {
            options = nil
        }
    }
    
    override func processRequest(connection: Connection)
    {
        let contentType:String? = connection.request!.value(forHeaderKey: HeaderKey.ContentType)
        let contentTypeIsJSON = contentType && contentType!.rangeOfString(MimeType.APPLICATION_JSON.string)
        let httpMethod:String = connection.request!.httpMethod
        
        if httpMethod != HTTPMethod.POST.toRaw()
            && httpMethod != HTTPMethod.PUT.toRaw()
            && httpMethod != HTTPMethod.DELETE.toRaw()
        {
            return
        }
        
        if contentTypeIsJSON
        {
            let data = connection.request!.data
            var error:NSError?
            let object:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error)
            
            if error
            {
                connection.response!.statusCode = StatusCode.BAD_REQUEST
                
                let errorMessage = [ "message":"Missing or invalid JSON was received.", "debugDescription":error!.debugDescription ]
                connection.setJSONResponseObject(errorMessage);
                
                return
            }
            
            if object
            {
                connection.setJSONRequestObject(object as NSDictionary)
            }
        }
    }
    
    override func processResponse(connection: Connection)
    {
        let responseObject = connection.JSONResponseObject()
        let accept:String? = connection.request!.value(forHeaderKey: HeaderKey.Accept)
        let acceptJSON = accept && accept!.rangeOfString(MimeType.APPLICATION_JSON.string)
        
        if acceptJSON || responseObject
        {
            if responseObject
            {
                var error:NSError?
                let data = NSJSONSerialization.dataWithJSONObject(responseObject, options: options, error: &error)
                
                if (connection.response!.statusCode.code == StatusCode.NOT_SET.code)
                {
                    connection.response!.statusCode = StatusCode.OK
                }
                connection.response!.setValue(MimeType.APPLICATION_JSON.string, forHeaderKey: HeaderKey.ContentType)
                connection.response!.data.appendData(data)
            }
            else
            {
                // Missing response object
                connection.response!.statusCode = StatusCode.NOT_IMPLEMENTED
                
                let errorMessage = [ "message":"Server did not return a response." ]
                connection.setJSONResponseObject(errorMessage);
                
                processResponse(connection)
            }
        }
    }
}