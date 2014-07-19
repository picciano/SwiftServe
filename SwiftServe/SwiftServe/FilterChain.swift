//
//  FilterChain.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class FilterChain
{
    var filters = Array<Filter>()
    
    func add(filter:Filter)
    {
        if filters.count > 0
        {
            let index = filters.count - 1
            let lastFiler = filters[index]
            lastFiler.nextFilter = filter
        }
        filters.append(filter)
    }
    
    func processFilters(connection:Connection)
    {
        if filters.count > 0
        {
            let firstFilter = filters[0]
            firstFilter.processFilter(connection)
        }
    }
}
