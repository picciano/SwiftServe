//
//  GZipCompressor.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/19/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

class GZipCompressor:Filter
{
    override func processResponse(connection:Connection)
    {
        var data = connection.response!.data
        
        if data != nil && shouldGZipResponse(connection)
        {
            var compressedData = data.barista_gzipDeflate()
            if compressedData != nil && !compressedData.isEqualToData(data)
            {
                connection.response!.data.setData(compressedData)
                connection.response!.setValue("gzip", forHeaderKey: HeaderKey.ContentEncoding)
            }
        }
    }
    
    func shouldGZipResponse(connection:Connection) -> Bool
    {
        var acceptEncoding:String? = connection.request!.value(forHeaderKey: HeaderKey.AcceptEncoding)
        return acceptEncoding && acceptEncoding!.rangeOfString("gzip")
    }
}