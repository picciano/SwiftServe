//
//  JSONSerialization.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/21/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

extension Connection
    {
    func JSONRequestObject() -> NSDictionary?
    {
        var value:Any? = customValues["JSONRequestObject"]
        return value as? NSDictionary
    }
    
    func setJSONRequestObject(object:NSDictionary)
    {
        customValues["JSONRequestObject"] = object
    }
    
    func JSONResponseObject() -> NSDictionary?
    {
        var value:Any? = customValues["JSONResponseObject"]
        return value as? NSDictionary
    }
    
    func setJSONResponseObject(object:NSDictionary)
    {
        customValues["JSONResponseObject"] = object
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
        let contentTypeIsJSON = contentType && contentType!.rangeOfString("application/json")
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
                
                var errorMessage = NSMutableDictionary()
                errorMessage.setValue("Missing or invalid JSON was received.", forKey: "message")
                errorMessage.setValue("\(error)", forKey: "error")
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
        let acceptJSON = accept && accept!.rangeOfString("application/json")
        
        if acceptJSON
        {
            if responseObject
            {
                var error:NSError?
                let data = NSJSONSerialization.dataWithJSONObject(responseObject, options: options, error: &error)
                
                if (connection.response!.statusCode.code == StatusCode.NOT_SET.code)
                {
                    connection.response!.statusCode = StatusCode.OK
                }
                connection.response!.setValue("application/json", forHeaderKey: HeaderKey.ContentType)
                connection.response!.data.appendData(data)
            }
            else
            {
                // Missing response object
                connection.response!.statusCode = StatusCode.NOT_IMPLEMENTED
                
                var errorMessage = NSMutableDictionary()
                errorMessage.setValue("Server did not return a response.", forKey: "message")
                connection.setJSONResponseObject(errorMessage);
                
                processResponse(connection)
            }
        }
    }
}