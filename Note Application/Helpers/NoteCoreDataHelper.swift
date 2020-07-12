//
//  NoteCoreDataHelper.swift
//  Note Application
//
//  Created by Andrew Arpin on 2020-07-12.
//  Copyright © 2020 Andrew Arpin. All rights reserved.
//

import CoreData
import Foundation

class NoteCoreDataHelper {
     private(set) static var count: Int = 0
        
        static func createNoteInCoreData(
            noteToBeCreated:          Note,
            intoManagedObjectContext: NSManagedObjectContext) {
            
            // Let’s create an entity and new note record
            let noteEntity = NSEntityDescription.entity(
                forEntityName: "NoteEntity",
                in:            intoManagedObjectContext)!
            
            let note = NSManagedObject(
                entity:     noteEntity,
                insertInto: intoManagedObjectContext)
    
            note.setValue(
                noteToBeCreated.noteID,
                forKey: "noteID")
            
            note.setValue(
                noteToBeCreated.title,
                forKey: "title")
            
            note.setValue(
                noteToBeCreated.text,
                forKey: "text")
            
            note.setValue(
                noteToBeCreated.time,
                forKey: "time")
            
            do {
                try intoManagedObjectContext.save()
                count += 1
            } catch let error as NSError {
                // TODO error handling
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
        static func changeNoteInCoreData(
            noteToBeChanged:        Note,
            inManagedObjectContext: NSManagedObjectContext) {
            
            // read managed object
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            let noteIdPredicate = NSPredicate(format: "noteID = %@", noteToBeChanged.noteID as CVarArg)
            
            fetchRequest.predicate = noteIdPredicate
            
            do {
                let fetchedNotesFromCoreData = try inManagedObjectContext.fetch(fetchRequest)
                let noteManagedObjectToBeChanged = fetchedNotesFromCoreData[0] as! NSManagedObject
                
                // make the changes
                noteManagedObjectToBeChanged.setValue(
                    noteToBeChanged.title,
                    forKey: "title")
    
                noteManagedObjectToBeChanged.setValue(
                    noteToBeChanged.text,
                    forKey: "text")
    
                noteManagedObjectToBeChanged.setValue(
                    noteToBeChanged.time,
                    forKey: "time")
    
                // save
                try inManagedObjectContext.save()
    
            } catch let error as NSError {
                // TODO error handling
                print("Could not change. \(error), \(error.userInfo)")
            }
        }
        
        static func readNotesFromCoreData(fromManagedObjectContext: NSManagedObjectContext) -> [Note] {
    
            var returnedNotes = [Note]()
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            fetchRequest.predicate = nil
            
            do {
                let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
                fetchedNotesFromCoreData.forEach { (fetchRequestResult) in
                    let noteManagedObjectRead = fetchRequestResult as! NSManagedObject
                    returnedNotes.append(Note(
                        noteID: noteManagedObjectRead.value(forKey: "noteID") as! UUID,
                        title: "title",
                        text: "text",
                        time: "time" as! Int64))
                }
            } catch let error as NSError {
                // TODO error handling
                print("Could not read. \(error), \(error.userInfo)")
            }
            
            // set note count
            self.count = returnedNotes.count
            
            return returnedNotes
        }
        
        static func readNoteFromCoreData(
            noteIdToBeRead:           UUID,
            fromManagedObjectContext: NSManagedObjectContext) -> Note? {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            let noteIdPredicate = NSPredicate(format: "noteID = %@", noteIdToBeRead as CVarArg)
            
            fetchRequest.predicate = noteIdPredicate
            
            do {
                let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
                let noteManagedObjectToBeRead = fetchedNotesFromCoreData[0] as! NSManagedObject
                return Note(
                    noteID: noteManagedObjectToBeRead.value(forKey: "noteID") as! UUID,
                    title: noteManagedObjectToBeRead.value(forKey: "title") as! String,
                    text: noteManagedObjectToBeRead.value(forKey: "text") as! String,
                    time: noteManagedObjectToBeRead.value(forKey: "time") as! Int64)
            } catch let error as NSError {
                // TODO error handling
                print("Could not read. \(error), \(error.userInfo)")
                return nil
            }
        }
    
        static func deleteNoteFromCoreData(
            noteIdToBeDeleted:        UUID,
            fromManagedObjectContext: NSManagedObjectContext) {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            
            let noteIdAsCVarArg: CVarArg = noteIdToBeDeleted as CVarArg
            let noteIdPredicate = NSPredicate(format: "noteID == %@", noteIdAsCVarArg)
            
            fetchRequest.predicate = noteIdPredicate
            
            do {
                let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
                let noteManagedObjectToBeDeleted = fetchedNotesFromCoreData[0] as! NSManagedObject
                fromManagedObjectContext.delete(noteManagedObjectToBeDeleted)
                
                do {
                    try fromManagedObjectContext.save()
                    self.count -= 1
                } catch let error as NSError {
                    // TODO error handling
                    print("Could not save. \(error), \(error.userInfo)")
                }
            } catch let error as NSError {
                // TODO error handling
                print("Could not delete. \(error), \(error.userInfo)")
            }
            
        }}
