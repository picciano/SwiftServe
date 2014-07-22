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
    let df = NSDateFormatter()
    
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
        let host:String = connection.socket.connectedHost=
        let user:String = "-" //TODO: Get Remote-User
        let date:String = dateAsFormattedString()
        let requestDescription:String = connection.request!.description
        let responseDescription:String = connection.response!.description
        
        let log = "\(host) \(user) [\(date)] \"\(requestDescription)\" \(responseDescription)"
        return log
    }
    
    func dateAsFormattedString() -> String
    {
        df.dateFormat = dateFormatString
        let dateString:String = df.stringFromDate(NSDate())
        return dateString
    }
}