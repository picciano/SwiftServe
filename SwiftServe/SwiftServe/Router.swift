//
//  Router.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/23/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Router:Filter
{
    override func processFilter(connection:Connection)
    {
        var handled = false
        
        if !includePaths || includePaths!.canRouteURL(connection.request!.url)
        {
            let classname = NSString(UTF8String: object_getClassName(self))
            let httpMethod = connection.request!.httpMethod
            let scheme = classname + httpMethod
            let parameters = [connectionKey:connection]
            
            handled = JLRoutes(forScheme: scheme).routeURL(connection.request!.url, withParameters: parameters)
        }
        
        if !handled && nextFilter
        {
            nextFilter!.processFilter(connection)
        }
    }
    
    func processRoutes(connection:Connection, parameters:Dictionary<NSObject,AnyObject>) -> Bool
    {
        // override this method in subclasses
        return true
    }
    
    func handler(parameters:NSDictionary!) -> Bool
    {
        if let connection = parameters[connectionKey] as? Connection
        {
            return processRoutes(connection, parameters: parameters)
        }
        
        return false
    }
    
    func addEndpoint(endpoint:String, httpMethod:HTTPMethod)
    {
        let classname = NSString(UTF8String: object_getClassName(self))
        let scheme = classname + httpMethod.toRaw()
        JLRoutes(forScheme: scheme).addRoute(endpoint, handler: handler)
    }
}