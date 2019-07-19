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
            tzID = property.data.value
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
            tzOffsetFrom = property.data.value
            configureCalendarTimeZoneString(property.data.value)
        case .tzOffsetTo:
            tzOffsetTo = property.data.value
        default:
            return
        }
    }
    
    private func configureCalendarTimeZoneString(_ value: String) {
        var parent = self.parent
        while let parentComponent = parent {
            if let calendar = parentComponent as? Calendar, nil == calendar.timeZoneString {
                calendar.timeZoneString = value
                return
            }
            
            parent = parentComponent.parent
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
            tzOffsetFrom = property.data.value
        case .tzOffsetTo:
            tzOffsetTo = property.data.value
        default:
            return
        }
    }
}
