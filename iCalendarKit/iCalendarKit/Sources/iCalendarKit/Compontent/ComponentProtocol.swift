//
//  ComponentProtocol.swift
//  Demo iOS
//
//  Created by roy on 2019/7/5.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public protocol ComponentProtocol: class {
    var type: RegistryTypes.Component { get set }
    var properties: [Result<Property, ParseError.Property>] { get set }
    
    var parent: ComponentProtocol? { get set }
    var firstChild: ComponentProtocol? { get set }
    var lastChild: ComponentProtocol? { get set }
    var leftBrother: ComponentProtocol? { get set }
    var rightBtother: ComponentProtocol? { get set }
    
    init(_ type: RegistryTypes.Component)
    
    func configure(_ property: Property)
    func specialPropertyDescription(step: Int, perStep: String) -> String
}

extension ComponentProtocol {
    public func addSub(component: ComponentProtocol) {
        component.parent = self
        
        guard hasChildren else {
            firstChild = component
            lastChild = component
            return
        }
        
        component.leftBrother = lastChild
        lastChild?.rightBtother = component
        lastChild = component
    }
    
    public var hasChildren: Bool {
        return nil != firstChild
    }
    
    public func removeSub(_ component: ComponentProtocol) {
        component.leftBrother?.rightBtother = component.rightBtother
        component.rightBtother?.leftBrother = component.leftBrother
    }
    
    func add(property: Result<Property, ParseError.Property>) {
        properties.append(property)
    }
    
    public var subCompontents: [ComponentProtocol]? {
        var child = firstChild
        var children = [ComponentProtocol]()
        while let component = child {
            children.append(component)
            child = component.next
        }
        
        return children.isEmpty ? nil : children
    }
}

extension ComponentProtocol {
    public var previous: ComponentProtocol? {
        return leftBrother
    }
    
    public var next: ComponentProtocol? {
        return rightBtother
    }
    
    public func description(_ step: Int = 0, _ perStep: String = "    ") -> String {
        // components
        var childrenDescription = ""
        var currentChild = firstChild
        
        while let child = currentChild {
            childrenDescription += child.description(step + 1)
            currentChild = currentChild?.next
        }
        
        let totalStep = (0...step).reduce("") { (r, _) in r + perStep }
        
        // property
        let propertyStep = totalStep + perStep
        let propertiesDescription = properties.reduce("") {
            switch $1 {
            case .failure(let error):
                return propertyStep + $0 + error.localizedDescription
            case .success(let property):
                return propertyStep + $0 + property.description(step, perStep)
            }
        }
        
        let extraDescription = specialPropertyDescription(step: step, perStep: perStep)
        
        return #"""
        \#(totalStep)-- -- -- -- -- --
        \#(totalStep)component: \#(type)
        \#(totalStep)properties: \#(propertiesDescription)
        \#(totalStep)extraDescription: \#(extraDescription)
        \#(totalStep)subComponents: \#(childrenDescription.isEmpty ? "none" : ("\n" + childrenDescription))
        
        """#
    }
    
    public func specialPropertyDescription(step: Int, perStep: String) -> String { return "none" }
}
