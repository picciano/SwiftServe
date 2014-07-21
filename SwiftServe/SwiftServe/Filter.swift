//
//  Filter.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

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
    
    func addRoute(route:String)
    {
        if !routes
        {
            var classname = NSString(UTF8String: object_getClassName(self))
            routes = JLRoutes(forScheme: classname)
        }
        
        routes!.addRoute(route, handler: { parameters in return (true as ObjCBool)} )
    }
}