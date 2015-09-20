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
                findOrCreateUser(userData, moc: managedContext)
            }
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    private func findOrCreateUser(newUser: NSDictionary, moc: NSManagedObjectContext) {
        if let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: moc),  user = NSManagedObject(entity: entity, insertIntoManagedObjectContext: moc) as? GPUser {
            user.username   = newUser.objectForKey(kGPUsername)    as! String
            user.password   = newUser.objectForKey(kGPPassword)    as! String
            user.email      = newUser.objectForKey(kGPEmail)       as! String
            user.userType   = newUser.objectForKey(kGPUsertype)    as! NSNumber
        }
    }
}