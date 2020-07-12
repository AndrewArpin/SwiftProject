//
//  NoteDataHelper.swift
//  Note Application
//
//  Created by Andrew Arpin on 2020-07-12.
//  Copyright © 2020 Andrew Arpin. All rights reserved.
//

import Foundation

class NoteDateHelper {
    static func convertDate(_ date: Date) -> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        
        let dateString = formatter.string(from: date)
        return dateString
    }
}
