//
//  Pareser.swift
//  Demo
//
//  Created by roy on 2019/7/10.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

class Parser {
    // Mark: - private properties
    /// 完成解析后的 component 的队列，一般队内有一个元素且是Calendar
    private var componentQueue = Queue<ComponentProtocol>()
    private var componentStack = Stack<ComponentProtocol>()
    
    /// 用于校验 Property 的类型
    private let propertyTypes = Set(RegistryTypes.Property.allCases.map{ $0.rawValue })
    
    /// 用于校验 Component 的类型
    private let componentTypes = Set(RegistryTypes.Component.allCases.map{ $0.rawValue })
    
    /// 收集以 "BEGIN"或"END"开始的错误行的错误
    private let componentErrorQueue = Queue<ParseError.Component>()
    
    /// 解析结果 Component
    var parsedComponents: Result<[ComponentProtocol], ParseError.Component> {
        guard let components = componentQueue.pullAll() else {
            return .failure(componentErrorQueue.head?.data ?? .unknown)
        }
        
        return .success(components)
    }
    
    /// 解析结果 Calendar
    var parsedCalendar: Result<Calendar, ParseError.Component> {
        guard
            let component = componentQueue.pull(),
            let calendar = component as? Calendar
        else {
            return .failure(.notBeginWithCalendar)
        }
        
        return .success(calendar)
    }
    
    /// initialise
    ///
    /// - Parameter content:
    private init(_ content: String) {
        parse(content)
    }
    
    /// convenience initialise with string
    ///
    /// - Parameter content: ics file content string
    /// - Throws: ParseError.Initial
    convenience init(withContent content: String) throws {
        let formatedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !formatedContent.isEmpty else {
            throw ParseError.Initial.emptyContent
        }

        self.init(formatedContent)
    }
    
    /// convenience initialise with url
    ///
    /// - Parameter url: ics file url
    /// - Throws: ParseError.Initial
    convenience init(url: URL) throws {
        guard
            let content = try? String(contentsOf: url, encoding: .utf8)
            else {
                throw ParseError.Initial.incorrectUrl
        }
        
        try self.init(withContent: content)
    }
    
    /// convenience initialise with file path
    ///
    /// - Parameter path: ics file path
    /// - Throws: ParseError.Initial
    convenience init(filePath path: String) throws {
        let url = URL(fileURLWithPath: path)
        
        do {
            try self.init(url: url)
        } catch let error as ParseError.Initial {
            throw error
        } catch {
            throw ParseError.Initial.incorrectPath
        }
    }
    
    /// parse content to component
    ///
    /// - Parameter content: ics file content string
    private func parse(_ content: String) {
        let separatedLines = separatedAndFormattedLines(for: content)
        separatedLines.forEach { parse(line: $0) }
    }
    
    /// separate content to lines by .newlines
    ///
    /// - Parameter content: ics file content
    /// - Returns: lines array
    private func separatedAndFormattedLines(for content: String) -> [String] {
        return content
            .components(separatedBy: .newlines)
            .filter{ !$0.isEmpty }
            .map{ $0.trimmingCharacters(in: .whitespaces) }
    }
    
    /// parse each line
    ///
    /// - Parameters:
    ///   - line: line string
    ///   - stack: component stack which is used for generate tree of component
    private func parse(line: String) {
        guard let (leading, symbolIndex, trailing) = getSeparatedLineInfo(line) else { return }

        switch leading {
        case RegistryTypes.Component.begin:
            parseComponentBegin(with: trailing)
        case RegistryTypes.Component.end:
            parseComponentEnd(with: trailing)
        default:
            let property = parseComponentProperty(withLeading: leading,
                                         separator: String(line[symbolIndex]),
                                         andTrailing: trailing)
            componentStack.top?.add(property: property)
        }
    }
    
    /// separated line for the first symbol(E.g: ";" or ":")
    ///
    /// - Parameter line: ics content line
    /// - Returns: prefix of line before symbol, symbol index, suffix of line behind symbol
    private func getSeparatedLineInfo(_ line: String) -> (leading: String, symbolIndex: String.Index, trailing: String)? {
        let index = line.firstIndex(where: { (character) -> Bool in
            character == ":" || character == ";"
        })
        
        guard let symbolIndex = index else { return nil }
        
        let leading = line.prefix(upTo: symbolIndex)
        let trailing = line.suffix(from: line.index(after: symbolIndex))
        
        return (String(leading), symbolIndex, String(trailing))
    }
    
    /// parse begin line of component. E.g: "BEGIN:VEVENT"
    ///
    /// - Parameters:
    ///   - trailing: suffix of line form the first symbol(":").  E.g: "VEVENT"
    ///   - stack: component stack which is used for generate tree of component
    private func parseComponentBegin(with trailing: String) {
        guard componentTypes.contains(trailing) else {
            componentErrorQueue.put(.incorrectBegin(trailing))
            return
        }
        
        let type = RegistryTypes.Component(rawValue: trailing)!
        let component = getComponent(for: type)
        
        if let parent = componentStack.top {
            parent.addSub(component: component)
        } else if let leftBrother = componentQueue.tail?.data {
            leftBrother.rightBtother = component
            component.leftBrother = leftBrother
        }
        
        componentStack.push(component)
    }
    
    /// parse end line of component. E.g: "END:VEVENT"
    ///
    /// - Parameters:
    ///   - trailing: suffix of line form the first symbol(":"). E.g: "VEVENT"
    private func parseComponentEnd(with trailing: String) {
        guard componentTypes.contains(trailing) else {
            componentErrorQueue.put(.incorrectEnd(trailing))
            return
        }
    
        guard let completedComponent = componentStack.pop() else { return }
        completedComponent.properties.forEach { [unowned completedComponent] in
            if case let .success(property) = $0 {
                completedComponent.configure(property)
            }
        }
        
        if componentStack.isEmpty {
            componentQueue.put(completedComponent)
        }
    }
    
    /// parse component property. E.g: "TZOFFSETFROM:+0800"
    ///
    /// - Parameters:
    ///   - leading: Prefix of line to the first symbol(":" or ";"), used to identify the type of property. E.g: "TZOFFSETFROM"
    ///   - separator: Symbol(":" or ";"), used to distinguish whether there are parameters
    ///   - trailing: Suffix of line behind the first symbol, Used to generate property content of parameter
    /// - Returns: Property of Error
    private func parseComponentProperty(withLeading leading: String,
                                        separator: String,
                                        andTrailing trailing: String) -> Result<Property, ParseError.Property> {
        guard propertyTypes.contains(leading), let name = RegistryTypes.Property(rawValue: leading) else {
            return .failure(.incorrectName(leading + separator + trailing))
        }
        
        // without parameters
        guard separator == ";", let colonIndex = trailing.firstIndex(of: ":") else {
            let property = Property(name: name,
                                    data: Value(name: .text, value: trailing),
                                    parameters: nil)
            return .success(property)
        }
        
        let paremeters = parseParameters(of: String(trailing.prefix(upTo: colonIndex)))
        let valueString = String(trailing.suffix(from: trailing.index(after: colonIndex)))
        
        let property = Property(name: name,
                                data: Value(name: .text, value: valueString),
                                parameters: paremeters)
        
        return .success(property)
    }
    
    
    /// generate oarameters
    ///
    /// - Parameter buffer: The string between first ";" and first ":".
    /// E.g:
    ///     line: "ATTENDEE;CN=erchengsan;ROLE=REQ-PARTICIPANT;PARTSTAT=NEED-REQUEST;RSVP=TRUE:MAILTO:erchengsan@foxmail.com"
    ///     buffet: "CN=erchengsan;ROLE=REQ-PARTICIPANT;PARTSTAT=NEED-REQUEST;RSVP=TRUE"
    /// - Returns: Paramters
    private func parseParameters(of buffer: String) -> [Result<Parameter, ParseError.Parameter>] {
        return buffer
            .components(separatedBy: ";")
            .compactMap { parameterPairs in
                guard let equalSignIndex = parameterPairs.firstIndex(of: "=") else {
                    return nil
                }
                
                let key = String(parameterPairs.prefix(upTo: equalSignIndex))
                let value = String(parameterPairs.suffix(from: parameterPairs.index(after: equalSignIndex)))
                
                guard let name = RegistryTypes.Parameter(rawValue: key) else {
                    return .failure(.incorrectName(buffer))
                }
                
                return .success(Parameter(name: name, value: value))
        }
    }
    
    /// Initial component entity
    ///
    /// - Parameter type: RegistryTypes.Component
    /// - Returns: entity
    private func getComponent(for type: RegistryTypes.Component) -> ComponentProtocol {
        switch type {
        case .vCalendar:
            return Calendar(type)
        case .vEvent:
            return Event(type)
        case .vTimeZone:
            return TimeZone(type)
        case .daylight:
            return TimeZoneDaylight(type)
        case .standard:
            return TimeZoneStandard(type)
        default:
            return Component(type)
        }
    }
}
