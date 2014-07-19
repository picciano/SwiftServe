//
//  Logging.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Logging:Filter
{
    override func processRequest()
    {
        var date = NSDate()
        println("\(date) Received request for \(request.URL)")
    }
}