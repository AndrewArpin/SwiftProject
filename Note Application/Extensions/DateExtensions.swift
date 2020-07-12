//
//  DateExtensions.swift
//  Note Application
//
//  Created by Andrew Arpin on 2020-07-12.
//  Copyright © 2020 Andrew Arpin. All rights reserved.
//

import Foundation

extension Date {
    func toSeconds() -> Int64 {
        return Int64(self.timeIntervalSince1970.rounded())
    }
    
    init(seconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(Double(seconds)))
    }
}
