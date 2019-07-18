//
//  Calendar.swift
//  iCalendarKit
//
//  Created by roy on 2019/7/9.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import Foundation

public final class Calendar: Component {
    public var timeZoneString: String?
    
    public required init(_ type: RegistryTypes.Component) {
        super.init(type)
    }
}
