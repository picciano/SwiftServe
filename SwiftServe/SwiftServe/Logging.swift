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
        
        let log = "\(host) \(ident) \(user) [\(date)] \"\(connection.request!)\" \(connection.response!)"
        return log
    }
}