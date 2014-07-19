//
//  StatusCode.swift
//  SwiftServe
//
//  Created by Anthony Picciano on 7/18/14.
//  Copyright (c) 2014 Anthony Picciano. All rights reserved.
//

import Foundation

struct StatusCode
{
    var code:Int
    var description:String
    
    static let CONTINUE = StatusCode(code:100, description:"Continue")
    static let SWITCHING_PROTOCOLS = StatusCode(code: 101, description:"Switching Protocols")
    static let OK = StatusCode(code: 200, description:"Okay")
    static let CREATED = StatusCode(code: 201, description:"Created")
    static let ACCEPTED = StatusCode(code: 202, description:"Accepted")
    static let NON_AUTHORITIVE_INFORMATION = StatusCode(code: 203, description:"Non-authoritive Information")
    static let NO_CONTENT = StatusCode(code: 204, description:"No Content")
    static let RESET_CONTENT = StatusCode(code: 205, description:"Reset Content")
    static let PARTIAL_CONTENT = StatusCode(code: 206, description:"Partial Content")
    static let MULTIPLE_CHOICES = StatusCode(code: 300, description:"Multiple Choices")
    static let MOVED_PERMANENTLY = StatusCode(code: 301, description:"Moved Permanently")
    static let FOUND = StatusCode(code: 302, description:"Found")
    static let SEE_OTHER = StatusCode(code: 303, description:"See Other")
    static let NOT_MODIFIED = StatusCode(code: 304, description:"Not Modified")
    static let USE_PROXY = StatusCode(code: 305, description:"Use Proxy")
    static let TEMPORARY_REDIRECT = StatusCode(code: 307, description:"Temporary Redirect")
    static let BAD_REQUEST = StatusCode(code: 400, description:"Bad Request")
    static let UNAUTHORIZED = StatusCode(code: 401, description:"Unauthorized")
    static let PAYMENT_REQUIRED = StatusCode(code: 402, description:"Payment Required")
    static let FORBIDDEN = StatusCode(code: 403, description:"Forbidden")
    static let NOT_FOUND = StatusCode(code: 404, description:"Not Found")
    static let METHOD_NOT_ALLOWED = StatusCode(code: 405, description:"Method Not Allowed")
    static let NOT_ACCEPTABLE = StatusCode(code: 406, description:"Not Acceptable")
    static let PROXY_AUTHENTICATION_REQUIRED = StatusCode(code: 407, description:"Proxy Authentication Required")
    static let REQUEST_TIMEOUT = StatusCode(code: 408, description:"Request Timeout")
    static let CONFLICT = StatusCode(code: 409, description:"Conflict")
    static let GONE = StatusCode(code: 410, description:"Gone")
    static let LENGTH_REQUIRED = StatusCode(code: 411, description:"Length Required")
    static let PRECONDITION_FAILED = StatusCode(code: 412, description:"Precondition Failed")
    static let REQUEST_ENTITY_TOO_LARGE = StatusCode(code: 413, description:"Request Entity Too Large")
    static let REQUEST_URI_TOO_LONG = StatusCode(code: 414, description:"Request URI Too Long")
    static let UNSUPPORTED_MEDIA_TYPE = StatusCode(code: 415, description:"Unsupported Media Type")
    static let REQUESTED_RANGE_NOT_SATISFIABLE = StatusCode(code: 416, description:"Requested Range Not Satisfiable")
    static let EXPECTATION_FAILED = StatusCode(code: 417, description:"Expectation Failed")
    static let SERVER_ERROR = StatusCode(code: 500, description:"Server Error")
    static let NOT_IMPLEMENTED = StatusCode(code: 501, description:"Not Implemented")
    static let BAD_GATEWAY = StatusCode(code: 502, description:"Bad Gateway")
    static let SERVICE_UNAVAILABLE = StatusCode(code: 503, description:"Service Unavailable")
    static let GATEWAY_TIMEOUT = StatusCode(code: 504, description:"Gateway Timeout")
    static let HTTP_VERSION_NOT_SUPPORTED = StatusCode(code: 505, description:"HTTP Version Not Supported")
}
