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
        println(logEntry(connection))
    }
    
    func logEntry(connection: Connection) -> String
    {
        let host = connection.socket.connectedHost
        let ident = "-" //TODO: Implement Ident
        let user = "-" //TODO: Get Remote-User
        let date = NSDate()
        let method = connection.request!.HTTPMethod
        let path = connection.request!.URL.path
        let version = connection.request!.version
        let responseCode = connection.response!.statusCode.code
        let contentLength = connection.response!.messageData.length
        
        let log = "\(host) \(ident) \(user) [\(date)] \"\(method) \(path) \(version)\" \(responseCode) \(contentLength)"
        return log
    }
}