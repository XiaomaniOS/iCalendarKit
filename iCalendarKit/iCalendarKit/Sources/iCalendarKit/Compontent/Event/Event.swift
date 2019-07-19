//
//  Event.swift
//  iCalendarKit
//
//  Created by roy on 2019/7/3.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public final class Event: Component {
    public var startDate: Property?
    public var endDate: Property?
    public var stampDate: String?
    public var createdDate: String?
    public var lastModifiedDate: String?
    public var sequences: Int?
    public var userID: String?
    public var location: String?
    public var summary: String?
    public var status: String?
    public var description: String?
    public var organizer: Property?
    public var attendees: [Property]?
    public var priority: Int?

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd'T'HHmmss'Z'"
        return formatter
    }()
    
    public required init(_ type: RegistryTypes.Component) {
        super.init(type)
    }
    
    public override func configure(_ property: Property) {
        switch property.name {
        case .uID:
            userID = property.data.value
        case .class:
            return
        case .status:
            return
        case .transp:
            return
        case .created:
            createdDate = property.data.value
        case .dtStamp:
            stampDate = property.data.value
        case .dtStart:
            startDate = property
        case .dtEnd:
            endDate = property
        case .summary:
            summary = property.data.value
        case .attendee:
            if nil == attendees {
                attendees = []
            }
            attendees?.append(property)
        case .location:
            location = property.data.value
        case .priority:
            priority = Int(property.data.value)
        case .sequence:
            sequences = Int(property.data.value)
        case .organizer:
            organizer = property
        default:
            return
        }
    }
    
    public override func specialPropertyDescription(step: Int = 0, perStep: String = "    ") -> String {
        let totalStep = (0...step + 1).reduce("", { (r, _)  in r + perStep })
        
        var attendeesDescription = ""
        if let attendees = attendees {
            attendeesDescription = attendees.reduce("", { (r, p) in r + p.description(step + 2, perStep) })
        }
        
        let result = #"""
        
        \#(totalStep)startDate ==> \#(startDate?.description(step + 1, perStep) ?? "")
        \#(totalStep)endDate ==> \#(endDate?.description(step + 1, perStep) ?? "")
        \#(totalStep)stampDate ==> \#(stampDate ?? "")
        \#(totalStep)createdDate ==> \#(createdDate ?? "")
        \#(totalStep)lastModifiedDate ==> \#(lastModifiedDate ?? "")
        \#(totalStep)sequences ==> \#(sequences ?? -10000)
        \#(totalStep)userID ==> \#(userID ?? "")
        \#(totalStep)location ==> \#(location ?? "")
        \#(totalStep)summary ==> \#(summary ?? "")
        \#(totalStep)status ==> \#(status ?? "")
        \#(totalStep)description ==> \#(description ?? "")
        \#(totalStep)organizer ==> \#(organizer?.description(step + 1, perStep) ?? "")
        \#(totalStep)attendees ==> \#(attendeesDescription)
        \#(totalStep)priority ==> \#(priority ?? -10000)
        """#
        
        return result
    }
}
