//
//  Component.swift
//  Demo iOS
//
//  Created by roy on 2019/7/5.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public class Component: ComponentProtocol {
    public var type: RegistryTypes.Component
    public var properties: [Result<Property, ParseError.Property>]
    
    public weak var parent: ComponentProtocol?
    public var firstChild: ComponentProtocol?
    public var lastChild: ComponentProtocol?
    public weak var leftBrother: ComponentProtocol?
    public var rightBtother: ComponentProtocol?

    public func configure(_ property: Property) {}
    
    required public init(_ type: RegistryTypes.Component) {
        self.type = type
        self.properties = []
    }
    
    public func specialPropertyDescription(step: Int, perStep: String) -> String {
        return ""
    }
}
