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
    override func processResponse(connection: Connection)
    {
        let host = connection.socket.connectedHost
        let ident = "-"
        let user = "-"
        let date = NSDate()
        let method = connection.request!.HTTPMethod
        let path = connection.request!.URL.path
        let version = connection.request!.version
        let responseCode = connection.response!.statusCode.code
        let contentLength = connection.response!.messageData.length
        println("\(host) \(ident) \(user) [\(date)] \"\(method) \(path) \(version)\" \(responseCode) \(contentLength)")
    }
}