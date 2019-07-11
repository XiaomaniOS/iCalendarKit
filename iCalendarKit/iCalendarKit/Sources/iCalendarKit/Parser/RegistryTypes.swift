//
//  Mark.swift
//  Demo
//
//  Created by roy on 2019/7/10.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

protocol Colonable: RawRepresentable where RawValue == String {}

extension Colonable {
    var colon: String {
        return ":"
    }
    
    var markWithColon: String {
        return rawValue + colon
    }
}

protocol Registrible: Colonable {}

extension Registrible {
    static var begin: String {
        return "BEGIN"
    }
    
    static var end: String {
        return "END"
    }
    
    var beginWithColon: String {
        return Self.begin + colon
    }
    
    var endWithColon: String {
        return Self.end + colon
    }
    
    var beginMark: String {
        return beginWithColon + rawValue
    }
    
    var endMark: String {
        return endWithColon + rawValue
    }
}

public struct RegistryTypes {
    public static let colon = ":"
    
    /// Component
    public enum Component: String, Registrible, CaseIterable {
        /// VCALENDAR | RFC 5545, Section 3.4
        case vCalendar = "VCALENDAR"
        
        /// VEVENT    | RFC 5545, Section 3.6.1
        case vEvent = "VEVENT"
        
        /// VTODO     | RFC 5545, Section 3.6.2
        case vTodo = "VTODO"
        
        /// VJOURNAL  | RFC 5545, Section 3.6.3
        case vJournal = "VJOURNAL"
        
        /// VFREEBUSY | RFC 5545, Section 3.6.4
        case vFreebusy = "VFREEBUSY"
        
        /// VTIMEZONE | RFC 5545, Section 3.6.5
        case vTimeZone = "VTIMEZONE"
        
        /// VALARM    | RFC 5545, Section 3.6.6
        case vAlarm = "VALARM"
        
        /// STANDARD  | RFC 5545, Section 3.6.5
        case standard = "STANDARD"
        
        /// DAYLIGHT  | RFC 5545, Section 3.6.5
        case daylight = "DAYLIGHT"
    }
}

extension RegistryTypes {
    public enum Property: String, Colonable, CaseIterable {
        /// CALSCALE        | RFC 5545, Section 3.7.1
        case calscale = "CALSCALE"
        
        // METHOD          | RFC 5545, Section 3.7.2
        case method = "METHOD"
        
        /// PRODID          | RFC 5545, Section 3.7.3
        case prodid = "PRODID"
        
        /// VERSION         | RFC 5545, Section 3.7.4
        case version = "VERSION"
        
        /// ATTACH          | RFC 5545, Section 3.8.1.1
        case attach = "ATTACH"
        
        /// CATEGORIES      | RFC 5545, Section 3.8.1.2
        case categorise = "CATEGORIES"
        
        /// CLASS           | RFC 5545, Section 3.8.1.3
        case `class` = "CLASS"
        
        /// COMMENT         | RFC 5545, Section 3.8.1.4
        case comment = "COMMENT"
        
        /// DESCRIPTION     | RFC 5545, Section 3.8.1.5
        case description = "DESCRIPTION"
        
        /// GEO             | RFC 5545, Section 3.8.1.6
        case geo = "GEO"
        
        /// LOCATION        | RFC 5545, Section 3.8.1.7
        case location = "LOCATION"
        
        /// PERCENT-COMPLET E| RFC 5545, Section 3.8.1.8
        case percentComplete = "PERCENT-COMPLET"
        
        /// PRIORITY        | RFC 5545, Section 3.8.1.9
        case priority = "PRIORITY"
        
        /// RESOURCES       | RFC 5545, Section 3.8.1.10
        case resources = "RESOURCES"
        
        /// STATUS          | RFC 5545, Section 3.8.1.11
        case status = "STATUS"
        
        /// SUMMARY         | RFC 5545, Section 3.8.1.12
        case summary = "SUMMARY"
        
        /// COMPLETED       | RFC 5545, Section 3.8.2.1
        case completed = "COMPLETED"
        
        /// DTEND           | RFC 5545, Section 3.8.2.2
        case dtEnd = "DTEND"
        
        /// DUE             | RFC 5545, Section 3.8.2.3
        case due = "DUE"
        
        /// DTSTART         | RFC 5545, Section 3.8.2.4
        case dtStart = "DTSTART"
        
        /// DURATION        | RFC 5545, Section 3.8.2.5
        case duration = "DURATION"
        
        /// FREEBUSY        | RFC 5545, Section 3.8.2.6
        case freeBusy = "FREEBUSY"
        
        /// TRANSP          | RFC 5545, Section 3.8.2.7
        case transp = "TRANSP"
        
        /// TZID            | RFC 5545, Section 3.8.3.1
        case tzID = "TZID"
        
        /// TZNAME          | RFC 5545, Section 3.8.3.2
        case tzName = "TZNAME"
        
        /// TZOFFSETFROM    | RFC 5545, Section 3.8.3.3
        case tzOffsetFrom = "TZOFFSETFROM"
        
        /// TZOFFSETTO      | RFC 5545, Section 3.8.3.4
        case tzOffsetTo = "TZOFFSETTO"
        
        /// TZURL           | RFC 5545, Section 3.8.3.5
        case tzUrl = "TZURL"
        
        /// ATTENDEE        | RFC 5545, Section 3.8.4.1
        case attendee = "ATTENDEE"
        
        /// CONTACT         | RFC 5545, Section 3.8.4.2
        case conract = "CONTACT"
        
        /// ORGANIZER       | RFC 5545, Section 3.8.4.3
        case organizer = "ORGANIZER"
        
        /// RECURRENCE-ID   | RFC 5545, Section 3.8.4.4
        case recurrenceID = "RECURRENCE-ID"
        
        /// RELATED-TO      | RFC 5545, Section 3.8.4.5
        case relatedTo = "RELATED-TO"
        
        /// URL             | RFC 5545, Section 3.8.4.6
        case url = "URL"
        
        /// UID             | RFC 5545, Section 3.8.4.7
        case uID = "UID"
        
        /// EXDATE          | RFC 5545, Section 3.8.5.1
        case exDate = "EXDATE"
        
        /// EXRULE          | Deprecated | [RFC2445], Section 4.8.5.2
        case exRule = "EXRULE"
        
        /// RDATE           | RFC 5545, Section 3.8.5.2
        case rDate = "RDATE"
        
        /// RRULE           | RFC 5545, Section 3.8.5.3
        case rRule = "RRULE"
        
        /// ACTION          | RFC 5545, Section 3.8.6.1
        case action = "ACTION"
        
        /// REPEAT          | RFC 5545, Section 3.8.6.2
        case `repeat` = "REPEAT"
        
        /// TRIGGER         | RFC 5545, Section 3.8.6.3
        case trigger = "TRIGGER"
        
        /// CREATED         | RFC 5545, Section 3.8.7.1
        case created = "CREATED"
        
        /// DTSTAMP         | RFC 5545, Section 3.8.7.2
        case dtStamp = "DTSTAMP"
        
        /// LAST-MODIFIED   | RFC 5545, Section 3.8.7.3
        case lastModified = "LAST-MODIFIED"
        
        /// SEQUENCE        | RFC 5545, Section 3.8.7.4
        case sequence = "SEQUENCE"
        
        /// REQUEST-STATUS  | RFC 5545, Section 3.8.8.3
        case requestStatus = "REQUEST-STATUS"
    }
}

extension RegistryTypes {
    /// Parameter
    public enum Parameter: String {
        /// ALTREP         | RFC 5545, Section 3.2.1
        case altrep = "ALTREP"
        
        /// CN             | RFC 5545, Section 3.2.2
        case cn = "CN"
        
        /// CUTYPE         | RFC 5545, Section 3.2.3
        case cuType = "CUTYPE"
        
        /// DELEGATED-FROM | RFC 5545, Section 3.2.4
        case delegatedFrom = "DELEGATED-FROM"
        
        /// DELEGATED-TO   | RFC 5545, Section 3.2.5
        case delegatedTo = "DELEGATED-TO"
        
        /// DIR            | RFC 5545, Section 3.2.6
        case dir = "DIR"
        
        /// ENCODING       | RFC 5545, Section 3.2.7
        case encoding = "ENCODING"
        
        /// FMTTYPE        | RFC 5545, Section 3.2.8
        case fmtType = "FMTTYPE"
        
        /// FBTYPE         | RFC 5545, Section 3.2.9
        case fbType = "FBTYPE"
        
        /// LANGUAGE       | RFC 5545, Section 3.2.10
        case language = "LANGUAGE"
        
        /// MEMBER         | RFC 5545, Section 3.2.11
        case member = "MEMBER"
        
        /// PARTSTAT       | RFC 5545, Section 3.2.12
        case parstart = "PARTSTAT"
        
        /// RANGE          | RFC 5545, Section 3.2.13
        case range = "RANGE"
        
        /// RELATED        | RFC 5545, Section 3.2.14
        case related = "RELATED"
        
        /// RELTYPE        | RFC 5545, Section 3.2.15
        case relType = "RELTYPE"
        
        /// ROLE           | RFC 5545, Section 3.2.16
        case role = "ROLE"
        
        /// RSVP           | RFC 5545, Section 3.2.17
        case rsvp = "RSVP"
        
        /// SENT-BY        | RFC 5545, Section 3.2.18
        case sentBy = "SENT-BY"
        
        /// TZID           | RFC 5545, Section 3.2.19
        case tzid = "TZID"
        
        /// VALUE          | RFC 5545, Section 3.2.20
        case value = "VALUE"
    }
}

extension RegistryTypes {
    /// Value Data Type
    public enum ValueData: String {
        /// BINARY          | RFC 5545, Section 3.3.1
        case binary = "BINARY"
        
        /// BOOLEAN         | RFC 5545, Section 3.3.2
        case boolean = "BOOLEAN"
        
        /// CAL-ADDRESS     | RFC 5545, Section 3.3.3
        case calAddress = "CAL-ADDRESS"
        
        /// DATE            | RFC 5545, Section 3.3.4
        case date = "DATE"
        
        /// DATE-TIME       | RFC 5545, Section 3.3.5
        case dateTime = "DATE-TIME"
        
        /// DURATION        | RFC 5545, Section 3.3.6
        case duration = "DURATION"
        
        /// FLOAT           | RFC 5545, Section 3.3.7
        case `float` = "FLOAT"
        
        /// INTEGER         | RFC 5545, Section 3.3.8
        case integer = "INTEGER"
        
        /// PERIOD          | RFC 5545, Section 3.3.9
        case period = "PERIOD"
        
        /// RECUR           | RFC 5545, Section 3.3.10
        case fecur = "RECUR"
        
        /// TEXT            | RFC 5545, Section 3.3.11
        case text = "TEXT"
        
        /// TIME            | RFC 5545, Section 3.3.12
        case time = "TIME"
        
        /// URI             | RFC 5545, Section 3.3.13
        case uri = "URI"
        
        /// UTC-OFFSET      | RFC 5545, Section 3.3.14
        case utcOffset = "UTC-OFFSET"
    }
}

extension RegistryTypes {
    /// Calendar User Type
    enum CalendarUserType {
        /// INDIVIDUAL         | RFC 5545, Section 3.2.3
        case individual
        
        /// GROUP              | RFC 5545, Section 3.2.3
        case group
        
        /// RESOURCE           | RFC 5545, Section 3.2.3
        case resource
        
        /// ROOM               | RFC 5545, Section 3.2.3
        case room
        
        /// UNKNOWN            | RFC 5545, Section 3.2.3
        case unknown
    }
}

extension RegistryTypes {
    /// Free/Busy Time Type
    enum FreeBusyTime {
        /// FREE                | RFC 5545, Section 3.2.9
        case free
        
        /// BUSY                | RFC 5545, Section 3.2.9
        case busy
        
        /// BUSY-UNAVAILABLE    | RFC 5545, Section 3.2.9
        case busyUnavaiable
        
        /// BUSY-TENTATIVE      | RFC 5545, Section 3.2.9 |
        case busyTentative
    }
}

extension RegistryTypes {
    /// Participant Status
    enum ParticipationStatuses {
        /// NEEDS-ACTION       | RFC 5545, Section 3.2.12
        case needsAction
        
        /// ACCEPTED           | RFC 5545, Section 3.2.12
        case accepted
        
        /// DECLINED           | RFC 5545, Section 3.2.12
        case declined
        
        /// TENTATIVE          | RFC 5545, Section 3.2.12
        case tentative
        
        /// DELEGATED          | RFC 5545, Section 3.2.12
        case delegated
        
        /// COMPLETED          | RFC 5545, Section 3.2.12
        case completed
        
        /// IN-PROCESS         | RFC 5545, Section 3.2.12
        case inProcess
    }
}


extension RegistryTypes {
    /// Relationship Type
    enum Relationship {
        /// CHILD             | RFC 5545, Section 3.2.15
        case child
        
        /// PARENT            | RFC 5545, Section 3.2.15
        case parent
        
        /// SIBLING           | RFC 5545, Section 3.2.15 |
        case sibing
    }
}


extension RegistryTypes {
    /// Role Type
    enum Role: String {
        /// CHAIR           | RFC 5545, Section 3.2.16
        case chair
        
        /// REQ-PARTICIPANT | RFC 5545, Section 3.2.16
        case reqParticipant
        
        /// OPT-PARTICIPANT | RFC 5545, Section 3.2.16
        case optParticipant
        
        /// NON-PARTICIPANT | RFC 5545, Section 3.2.16
        case nonParticipant
    }
}


extension RegistryTypes {
    /// Action
    enum Action: String {
        /// AUDIO     | Current    | RFC 5545, Section 3.8.6.1
        case audio
        
        /// DISPLAY   | Current    | RFC 5545, Section 3.8.6.1
        case display
        
        /// EMAIL     | Current    | RFC 5545, Section 3.8.6.1
        case email
        
        /// PROCEDURE | Deprecated | [RFC2445], Section 4.8.6.1
        case procedure
    }
}


extension RegistryTypes {
    /// Classification
    enum Classification: String {
        /// PUBLIC         | RFC 5545, Section 3.8.1.3
        case `public`
        
        /// PRIVATE        | RFC 5545, Section 3.8.1.3
        case `private`
        
        /// CONFIDENTIAL   | RFC 5545, Section 3.8.1.3
        case confidential
        
    }
}


extension RegistryTypes {
    enum method: String {
        case request = "REQUEST"
    }
}
