//
//  iCalendarKit_iOSTests.swift
//  iCalendarKit iOSTests
//
//  Created by roy on 2019/7/11.
//

import XCTest
@testable import iCalendarKit

class iCalendarKit_iOSTests: XCTestCase {

    enum CalendarFile: String {
        case calendar
        case basic
        case totalTimeZone
        case universityFormatted
        case university
        
        var path: String {
            return bundle.path(forResource: rawValue, ofType: "ics")!
        }
        
        var bundle: Bundle {
            return Bundle(for: iCalendarKit_iOSTests.self)
        }
    }
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalendarInitial() {
        let path = CalendarFile.calendar.path
        
        XCTAssertThrowsError(try CalendarKit.prase(withFilePath: path + "error path"), "") { error in
            XCTAssertEqual(error as! iCalendarKit.ParseError.Initial, .incorrectUrl)
        }
        
        let url = URL(fileURLWithPath: path + "error url")
        XCTAssertThrowsError(try CalendarKit.prase(withUrl: url), "") { error in
            XCTAssertEqual(error as! iCalendarKit.ParseError.Initial, .incorrectUrl)
        }

        XCTAssertThrowsError(try CalendarKit.prase(withContent: "   \n"), "") { error in
            XCTAssertEqual(error as! iCalendarKit.ParseError.Initial, .emptyContent)
        }

//        XCTAssertThrowsError(try CalendarKit.prase(withFilePath: CalendarFile.university.path)) { error in
//            XCTAssertEqual(iCalendarKit.ParseError.Component.self, error.Type)
//        }

        XCTAssertNoThrow(try CalendarKit.prase(withFilePath: path))
    }
    
    func testCalendarComponent() {
        let calendar = try! CalendarKit.prase(withFilePath: CalendarFile.calendar.path)
        
        XCTAssertEqual(calendar.type, RegistryTypes.Component.vCalendar)
        XCTAssertTrue(calendar.hasChildren)
        XCTAssertNil(calendar.parent)
        XCTAssertNil(calendar.leftBrother)
        XCTAssertNil(calendar.rightBtother)
        XCTAssertEqual(calendar.firstChild!.type, .vTimeZone)
        XCTAssertEqual(calendar.firstChild?.next?.type, .vEvent)
        XCTAssertEqual(calendar.lastChild?.type, .vEvent)
//        XCTAssertNotNil(calendar.subCompontents)
        XCTAssertGreaterThan(calendar.properties.count, 1)
        
        XCTAssertNotNil(calendar.lastChild)
        let event = calendar.lastChild!
        XCTAssertNotNil(event)
        XCTAssertTrue(event.hasChildren)
        XCTAssertEqual(event.type, .vEvent)
        XCTAssertEqual(event.parent?.type, .vCalendar)

        
        XCTAssertNil(calendar.parent)
        XCTAssertNil(calendar.leftBrother)
        XCTAssertNil(calendar.rightBtother)
        
        XCTAssertEqual(calendar.firstChild?.next?.type, .vEvent)
        XCTAssertEqual(calendar.lastChild?.type, .vEvent)
//        XCTAssertNotNil(calendar.subCompontents)
        XCTAssertGreaterThan(calendar.properties.count, 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
