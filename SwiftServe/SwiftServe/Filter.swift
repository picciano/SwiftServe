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
    var includePaths:JLRoutes?
    var nextFilter:Filter?
    
    init()
    {
        
    }
    
    func processFilter(connection:Connection)
    {
        if !includePaths || includePaths!.canRouteURL(connection.request!.url)
        {
            processRequest(connection)
        }
        
        if nextFilter
        {
            nextFilter!.processFilter(connection)
        }
        
        if !includePaths || includePaths!.canRouteURL(connection.request!.url)
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
    
    func includePath(path:String)
    {
        if !includePaths
        {
            let classname = NSString(UTF8String: object_getClassName(self))
            includePaths = JLRoutes(forScheme: classname)
        }
        
        includePaths!.addRoute(path, handler: nil)
    }
}