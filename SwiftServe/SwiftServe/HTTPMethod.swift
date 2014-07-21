//
//  HTTPMethod.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/21/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

enum HTTPMethod:String
{
    // common methods
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    
    // lesser used methods
    case OPTIONS = "OPTIONS"
    case HEAD = "HEAD"
    case TRACE = "TRACE"
}