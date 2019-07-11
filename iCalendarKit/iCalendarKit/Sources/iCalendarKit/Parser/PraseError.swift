//
//  PraseError.swift
//  iCalendarKit
//
//  Created by roy on 2019/7/11.
//

import Foundation

public struct ParseError {
    public enum Initial: Error {
        case incorrectPath
        case incorrectUrl
        case emptyContent
        case invalidatedFormatt
    }
    
    public enum Component: Error {
        case incorrectBegin(String)
        case incorrectEnd(String)
        case notBeginWithCalendar
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .incorrectBegin(let text):
                return "Parse error in component begin for value: \(text)"
            case .incorrectEnd(let text):
                return "Parse error in component begin for value: \(text)"
            case .notBeginWithCalendar:
                return "ics file is not begain with VCALENDAR"
            case .unknown:
                return "unknown"
            }
        }
    }
    
    public enum Property: Error {
        case incorrectName(String)
        
        var localizedDescription: String {
            switch self {
            case .incorrectName(let text):
                return "Parse error in property name at line: \(text)"
            }
        }
    }
    
    public enum Parameter: Error {
        case incorrectName(String)
        
        var localizedDescription: String {
            switch self {
            case .incorrectName(let text):
                return "Parse error in parameter name at line: \(text)"
            }
        }
    }
    
    
    public enum Line: Error {
        case withoutBeginTag
        
        var localizedDescription: String {
            switch self {
            case .withoutBeginTag:
                return #"Got a data line\, but could not find a property name or component begin tag"#
            }
        }
    }
}
