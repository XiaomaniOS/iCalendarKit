//
//  ViewController.swift
//  Demo
//
//  Created by roy on 2019/7/11.
//  Copyright © 2019 xiaoman. All rights reserved.
//

import UIKit
import iCalendarKit

class ViewController: UIViewController {
    enum CalendarFile: String, CaseIterable {
        case calendar
//        case basic
//        case totalTimeZone
//        case universityFormatted
//        case university
        
        var path: String {
            return bundle.path(forResource: rawValue, ofType: "ics") ?? ""
        }
        
        var bundle: Bundle {
            return Bundle(for: ViewController.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testParser()
    }
    
    func testParser() {
        CalendarFile.allCases.forEach {
            do {
//                let calendar = try CalendarKit.prase(withFilePath: $0.path)
//                print(calendar.description())
                
                let components = try CalendarKit.praseComponent(withFilePath: $0.path)
                print(components.count)
                print(components.first!.description())
            } catch let error {
                print(error)
            }
            print("=== === === === === === === === === === === === === === === === === === === === === ")
        }
        
    }
}

