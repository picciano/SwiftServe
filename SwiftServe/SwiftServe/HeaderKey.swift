//
//  HeaderKey.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

enum HeaderKey:String
{
    case Accept = "Accept"
    case AcceptEncoding = "Accept-Encoding"
    case AcceptLanguage = "Accept-Language"
    case Authorization = "Authorization"
    case CacheControl = "Cache-Control"
    case Connection = "Connection"
    case Content = "Content"
    case ContentLength = "Content-Length"
    case Cookie = "Cookie"
    case DNT = "DNT"
    case Host = "Host"
    case UserAgent = "User-Agent"
}