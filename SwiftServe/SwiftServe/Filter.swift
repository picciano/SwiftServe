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
    
    func processFilter(#request:Request, response:Response)
    {
        processRequest(request:request, response:response)
        
        if nextFilter
        {
            nextFilter!.processFilter(request:request, response:response)
        }
        
        processResponse(request:request, response:response)
    }
    
    func processRequest(#request:Request, response:Response)
    {
        
    }
    
    func processResponse(#request:Request, response:Response)
    {
        
    }
}