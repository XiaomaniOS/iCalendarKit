//
//  TimeZone.swift
//  Demo iOS
//
//  Created by roy on 2019/7/9.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public final class TimeZone: Component {
    public var tzID: String?
    
    public required init(_ type: RegistryTypes.Component) {
        super.init(type)
    }
    
    public override func configure(_ property: Property) {
        switch property.name {
        case .tzID:
            tzID = property.valueInfo.value
        default:
            return
        }
    }
}

public final class TimeZoneStandard: Component {
    public var tzOffsetFrom: String?
    public var tzOffsetTo: String?
    
    public required init(_ type: RegistryTypes.Component) {
        super.init(type)
    }
    
    public override func configure(_ property: Property) {
        switch property.name {
        case .tzOffsetFrom:
            tzOffsetFrom = property.valueInfo.value
        case .tzOffsetTo:
            tzOffsetTo = property.valueInfo.value
        default:
            return
        }
    }
}

public final class TimeZoneDaylight: Component {
    public var tzOffsetFrom: String?
    public var tzOffsetTo: String?
    
    public required init(_ type: RegistryTypes.Component) {
        super.init(type)
    }
    
    public override func configure(_ property: Property) {
        switch property.name {
        case .tzOffsetFrom:
            tzOffsetFrom = property.valueInfo.value
        case .tzOffsetTo:
            tzOffsetTo = property.valueInfo.value
        default:
            return
        }
    }
}
