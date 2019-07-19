//
//  Property.swift
//  iCalendarKit
//
//  Created by roy on 2019/7/11.
//

import Foundation

public struct Value {
    public private(set) var name: RegistryTypes.ValueData
    public private(set) var value: String
}

public struct Parameter {
    public private(set) var name: RegistryTypes.Parameter
    public private(set) var value: String
    
    var description: String {
        return "--> \(name): \(value)"
    }
}

public struct Property {
    public private(set) var name: RegistryTypes.Property
    public private(set) var data: Value
    public private(set) var parameters: [Result<Parameter, ParseError.Parameter>]?
    
    func description(_ step: Int = 0, _ perStep: String = "    " ) -> String {
        let totalStep = (0...step + 1).reduce("", { (r, _)  in r + perStep })
        
        var result = "\n" + totalStep + "=> \(name): \(data.value)"
        
        if let parameters = parameters {
            result += parameters.reduce("\n" + totalStep + "parameters:" + "\n", {
                let description: String
                switch $1 {
                case .failure(let error):
                    description = error.localizedDescription
                case .success(let parameter):
                    description = parameter.description
                }
                
                return $0 + (totalStep + perStep) + description + "\n"
            })
        }
        return result
    }
}
