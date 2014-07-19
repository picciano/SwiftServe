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
    let request:Request
    let response:Response
    var nextFilter:Filter?
    
    init(request:Request, response:Response)
    {
        self.request = request
        self.response = response
    }
    
    func processFilter()
    {
        processRequest()
        
        if nextFilter
        {
            nextFilter!.processFilter()
        }
        
        processResponse()
    }
    
    func processRequest()
    {
        
    }
    
    func processResponse()
    {
        
    }
}