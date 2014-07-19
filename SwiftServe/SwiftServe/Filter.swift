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
    var nextFilter:Filter?
    
    init()
    {
        
    }
    
    func processFilter(connection:Connection)
    {
        processRequest(connection)
        if nextFilter
        {
            nextFilter!.processFilter(connection)
        }
        processResponse(connection)
    }
    
    func processRequest(connection:Connection)
    {
        // override this method in subclasses
    }
    
    func processResponse(connection:Connection)
    {
        // override this method in subclasses
    }
}