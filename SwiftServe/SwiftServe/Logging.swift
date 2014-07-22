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
    var dateFormatString:String
    
    init(dateFormatString:String = "MMM/dd/yyyy hh:mm:ss ZZZZ")
    {
        self.dateFormatString = dateFormatString
    }
    
    override func processResponse(connection: Connection)
    {
        println(logEntry(connection))
    }
    
    func logEntry(connection: Connection) -> String
    {
        let host = connection.socket.connectedHost
        let ident = "-" //TODO: Implement Ident
        let user = "-" //TODO: Get Remote-User
        
        let df = NSDateFormatter()
        df.dateFormat = dateFormatString
        let dateString = df.stringFromDate(NSDate())
        
        // line below leaks memory. swift bug?
        // let log = "\(host) \(ident) \(user) [\(date)] \"\(connection.request!.description)\" \(connection.response!.description)"
        
        var log = host + " " + ident + " " + user
        log += " [" + dateString + "]"
        log += " \"" + connection.request!.description
        log += "\" " + connection.response!.description
        
        return log
    }
}