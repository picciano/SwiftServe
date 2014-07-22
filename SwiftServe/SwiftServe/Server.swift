//
//  Server.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/17/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class Server: GCDAsyncSocketDelegate
{
    let filterChain = FilterChain();
    let boundHost:String?
    let port:UInt16
    @lazy var socket:GCDAsyncSocket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
    var isListening = false
    
    init(boundHost: String?, port: UInt16)
    {
        if boundHost {
            self.boundHost = boundHost!
        }
        self.port = port
        
        // leaks
        // println("Server created with host: \(self.boundHost) and port: \(self.port).")
        
        var message = "Server created with host: "
        if self.boundHost
        {
            message += self.boundHost!
        }
        else
        {
            message += "*"
        }
        message += " and port: \(self.port)"
        println(message)
    }
    
    convenience init(port:UInt16)
    {
        self.init(boundHost: nil, port: port)
    }
    
    func startServer() -> Bool
    {
        if isListening
        {
            return false
        }
        
        var error:NSError?
        if !socket.acceptOnInterface(boundHost, port: port, error: &error)
        {
            println("Couldn't start socket: \(error)")
        }
        else
        {
            println("Listening on \(port).")
            isListening = true
        }
        
        return isListening
    }
    
    func stopServer() -> Bool
    {
        if isListening
        {
            socket.disconnect()
            isListening = false
            return true
        }
        return false
    }
    
    func runForever()
    {
        while true
        {
            NSRunLoop.mainRunLoop().run()
        }
    }
    
    func socket(socket:GCDAsyncSocket!, didAcceptNewSocket newSocket:GCDAsyncSocket!)
    {
        Connection(socket: newSocket, filterChain:filterChain)
    }
    
}