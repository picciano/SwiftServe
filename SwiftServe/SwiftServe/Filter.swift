//
//  Filter.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

// TODO: class variable are not yet supported
let connectionKey = "SwiftServe.Connection"

class Filter
{
    var routes:JLRoutes?
    var nextFilter:Filter?
    
    init()
    {
        
    }
    
    func processFilter(connection:Connection)
    {
        if !routes || routes!.canRouteURL(connection.request!.url)
        {
            processRequest(connection)
        }
        
        if routes
        {
            let parameters = [connectionKey:connection]
            let handled = routes!.routeURL(connection.request!.url, withParameters: parameters)
        }
        
        if nextFilter
        {
            nextFilter!.processFilter(connection)
        }
        
        if !routes || routes!.canRouteURL(connection.request!.url)
        {
            processResponse(connection)
        }
    }
    
    func processRequest(connection:Connection)
    {
        // override this method in subclasses
    }
    
    func processResponse(connection:Connection)
    {
        // override this method in subclasses
    }
    
    func processRoutes(connection:Connection, parameters:Dictionary<NSObject,AnyObject>) -> Bool
    {
        // override this method in subclasses
        return true
    }
    
    func includePath(path:String)
    {
        if !routes
        {
            let classname = NSString(UTF8String: object_getClassName(self))
            routes = JLRoutes(forScheme: classname)
        }
        
        routes!.addRoute(path, handler: handler)
    }
    
    func handler(parameters:NSDictionary!) -> Bool
    {
        if let connection = parameters[connectionKey] as? Connection
        {
            return processRoutes(connection, parameters: parameters)
        }
        
        return false
    }
}