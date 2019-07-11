//
//  Event.swift
//  iCalendarKit
//
//  Created by roy on 2019/7/3.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public final class Event: Component {
    public var startDate: Date?
    public var endDate: Date?
    public var stampDate: Date?
    public var createdDate: Date?
    public var lastModifiedDate: Date?
    public var sequences: Int?
    public var userID: String?
    public var location: String?
    public var summary: String?
    public var status: String?
    public var description: String?
    public var organizer: Property?
    public var attendees: Property?
    public var priority: Int?

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = Foundation.TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        return formatter
    }()
    
    public required init(_ type: RegistryTypes.Component) {
        super.init(type)
    }
    
    public override func configure(_ property: Property) {
        switch property.name {
        case .uID:
            userID = property.valueInfo.value
        case .class:
            return
        case .status:
            return
        case .transp:
            return
        case .created:
            createdDate = dateFormatter.date(from: property.valueInfo.value)
        case .dtStamp:
            stampDate = dateFormatter.date(from: property.valueInfo.value)
        case .dtStart:
            startDate = dateFormatter.date(from: property.valueInfo.value)
        case .dtEnd:
            endDate = dateFormatter.date(from: property.valueInfo.value)
        case .summary:
            summary = property.valueInfo.value
        case .attendee:
            attendees = property
        case .location:
            location = property.valueInfo.value
        case .priority:
            priority = Int(property.valueInfo.value)
        case .sequence:
            sequences = Int(property.valueInfo.value)
        case .organizer:
            organizer = property
        default:
            return
        }
    }
    
    public override func specialPropertyDescription(step: Int = 0, perStep: String = "    ") -> String {
        let totalStep = (0...step + 1).reduce("", { (r, _)  in r + perStep })
        
        let result = #"""
        
        \#(totalStep)startDate ==> \#(startDate ?? Date())
        \#(totalStep)endDate ==> \#(endDate ?? Date())
        \#(totalStep)stampDate ==> \#(stampDate ?? Date())
        \#(totalStep)createdDate ==> \#(createdDate ?? Date())
        \#(totalStep)lastModifiedDate ==> \#(lastModifiedDate ?? Date())
        \#(totalStep)sequences ==> \#(sequences ?? -10000)
        \#(totalStep)userID ==> \#(userID ?? "")
        \#(totalStep)location ==> \#(location ?? "")
        \#(totalStep)summary ==> \#(summary ?? "")
        \#(totalStep)status ==> \#(status ?? "")
        \#(totalStep)description ==> \#(description ?? "")
        \#(totalStep)organizer ==> \#(organizer?.description(step + 1, perStep) ?? "")
        \#(totalStep)attendees ==> \#(attendees?.description(step + 1, perStep) ?? "")
        \#(totalStep)priority ==> \#(priority ?? -10000)
        """#
        
        return result
    }
}
