//
//  UserDetailsViewModel.swift
//  UIKit Basic Project 1
//
//  Created by Asal Macbook 1 on 07/06/2020.
//  Copyright © 2020 Mustafa Birat. All rights reserved.
//

import UIKit
import CoreData


class UserDetailsViewModel {
    
    var user: User?
    private var userDefaults = UserDefaults.standard
    
    init(user: User?) {
        self.user = user
    }
    
    
    func saveNote(noteText: String?, completion: @escaping (Bool) -> Void) {
        if noteText == "" {return}
        guard let userId = user?.id else {
            completion(false)
            return
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {return}
        
        if userDefaults.bool(forKey: "\(userId)") {
            
            getNote()?.content = noteText
            
        } else {
            let note = Note(entity: entity, insertInto: context)
            note.content = noteText
            note.user_id = Int16(userId)
        }
        
        do {
            try context.save()
            userDefaults.setValue(true, forKey: "\(userId)")
            completion(true)
            
        } catch let error as NSError {
            print("could not save note! \(error)")
            completion(false)
        }
    }
    
    
    func getNote() -> Note? {
        do {
            guard let userId = user?.id else {
                return nil
            }
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "user_id == %@", NSNumber(value: Int16(userId)))
            
            let notes = try context.fetch(fetchRequest)
            return notes.first
            
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    func noteExist() -> Bool {
        guard let userId = user?.id else {
            return false
        }
        return userDefaults.bool(forKey: "\(userId)")
    }
}
