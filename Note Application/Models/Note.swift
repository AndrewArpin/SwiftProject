//
//  Note.swift
//  Note Application
//
//  Created by Andrew Arpin on 2020-07-12.
//  Copyright © 2020 Andrew Arpin. All rights reserved.
//

import Foundation

class Note {
    private(set) var noteID: UUID
    private(set) var title: String
    private(set) var text:String
    private(set) var time: Int64
    
    init(noteID: UUID, title: String, text: String,time: Int64) {
        self.noteID = noteID
        self.title = title
        self.text = text
        self.time = time
    }
    
    init(title: String, text: String, time: Int64) {
        self.noteID = UUID()
        self.title = title
        self.text = text
        self.time = time
    }
}
