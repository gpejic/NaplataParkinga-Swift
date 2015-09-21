//
//  GPCoreDataManager.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 19/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import CoreData
import UIKit

let kGPUsername = "name"
let kGPPassword = "password"
let kGPEmail    = "email"
let kGPUsertype = "type"

class GPCoreDataManager {
    
    static let sharedInstance = GPCoreDataManager()
    
    func saveArrayToCoreData(dataArray: NSArray) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate, managedContext = appDelegate.managedObjectContext {
            for userData in dataArray as! [NSDictionary] {
                createNewUser(userData, moc: managedContext)
            }
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    func createNewUser(newUser: NSDictionary, moc: NSManagedObjectContext) {
        if let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: moc),  user = NSManagedObject(entity: entity, insertIntoManagedObjectContext: moc) as? GPUser {
            user.username   = newUser.objectForKey(kGPUsername)    as! String
            user.password   = newUser.objectForKey(kGPPassword)    as! String
            user.email      = newUser.objectForKey(kGPEmail)       as! String
            user.userType   = newUser.objectForKey(kGPUsertype)    as! NSNumber
        }
    }
    
    func getCurrentUser() -> GPUser {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"isCurrentUser == YES")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        let user = fetchedResults?.last as! GPUser
        return user

    }
    
    func logoutCurrentUser() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"isCurrentUser == YES")
        
        var importError: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &importError) as? [NSManagedObject]
        
        if let userList = fetchedResults {
            for user in userList as! [GPUser] {
                user.isCurrentUser = false
            }
        }
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    func checkUsernameAndEmail(username: String, email: String) -> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"username == %@ || email == %@", username, email)
        
        var importError: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &importError) as? [NSManagedObject]
        
        if let userList = fetchedResults {
            if userList.count != 0 {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
}