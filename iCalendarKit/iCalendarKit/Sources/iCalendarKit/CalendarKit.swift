//
//  CalendarKit.swift
//  Demo
//
//  Created by roy on 2019/7/10.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public struct CalendarKit {
    public static func prase(withContent content: String) throws -> Calendar {
        return try parsedCalendar(for: try Parser(withContent: content))
    }
    
    public static func prase(withUrl url: URL) throws -> Calendar {
        return try parsedCalendar(for: try Parser(url: url))
    }
    
    public static func prase(withFilePath path: String) throws -> Calendar {
        return try parsedCalendar(for: Parser(filePath: path))
    }
    
    private static func parsedCalendar(for parser: Parser) throws -> Calendar {
        switch parser.parsedCalendar {
        case .success(let calendar):
            return calendar
        case .failure(let error):
            throw error
        }
    }
    
    public static func praseComponent(withContent content: String) throws -> [ComponentProtocol] {
        return try parsedComponent(for: Parser(withContent: content))
    }
    
    public static func praseComponent(withUrl url: URL) throws -> [ComponentProtocol] {
        return try parsedComponent(for: try Parser(url: url))
    }
    
    public static func praseComponent(withFilePath path: String) throws -> [ComponentProtocol] {
        return try parsedComponent(for: try Parser(filePath: path))
    }
    
    private static func parsedComponent(for parser: Parser) throws -> [ComponentProtocol] {
        switch parser.parsedComponents {
        case .success(let components):
            return components
        case .failure(let error):
            throw error
        }
    }
}

public enum CalendarError: Error {
    case failure
}
