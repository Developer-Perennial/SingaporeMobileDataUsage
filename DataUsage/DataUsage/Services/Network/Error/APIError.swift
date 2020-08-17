//
//  APIError.swift
//  DataUsage
//
//  Created by Pere Dev on 27/07/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

import Foundation

public struct APIError: Swift.Error {
    
    var parseError: ParseError?
    
    var error: Error?
    
    var data: Data?
    
    var internetNotAvailble = false
}

public struct ParseError: Swift.Error {
    public let error: Error?
    public let file: String
    public let line: Int
    public let function: String
    
    public init(_ error: Error?, file: String = #file, line: Int = #line, function: String = #function) {
        self.error = error
        self.file = file
        self.line = line
        self.function = function
    }
}
