//
//  NSDataExptensions.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

extension NSData
{
    func byteDataAsUInt8() -> UInt8[]
    {
        var array = UInt8[](count:length, repeatedValue: 0)
        getBytes(&array)
        
        return array
    }
}