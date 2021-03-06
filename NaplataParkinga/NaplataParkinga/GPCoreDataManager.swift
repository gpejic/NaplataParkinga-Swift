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

let kGPUsername     = "name"
let kGPPassword     = "password"
let kGPEmail        = "email"
let kGPUsertype     = "type"
let kGPCredit       = "credit"
let kGPParkingname  = "parkingName"
let kGPPrice        = "price"
let kGPPlate        = "plate"

enum EntityTypes {
    case User
    case Parking
}

class GPCoreDataManager {
    
    static let sharedInstance = GPCoreDataManager()
    
    func saveArrayToCoreData(dataArray: NSArray, entityType: EntityTypes) {
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate, managedContext = appDelegate.managedObjectContext {
            for data in dataArray as! [NSDictionary] {
                switch entityType {
                case .User:
                    createNewUser(data, moc: managedContext)
                case .Parking:
                    createNewParking(data, moc: managedContext)
                default:
                    break
                }
            }
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    func createNewUser(newUser: NSDictionary, moc: NSManagedObjectContext) {
        
        let userList = checkIfUserExists(newUser.objectForKey(kGPUsername) as! String)
        
        if userList.count > 0 {
            if let user = userList.lastObject as? GPUser {
                user.username   = newUser.objectForKey(kGPUsername)    as! String
                user.password   = newUser.objectForKey(kGPPassword)    as! String
                user.email      = newUser.objectForKey(kGPEmail)       as! String
                user.userType   = newUser.objectForKey(kGPUsertype)    as! NSNumber
                user.plate      = newUser.objectForKey(kGPPlate)       as! String
                user.isCurrentUser =  false
                if let userCredit = newUser.objectForKey(kGPCredit) as? NSNumber {
                    user.balance = userCredit
                }
                else {
                    user.balance = NSNumber(integer: 0)
                }
            }
        }
        else {
            if let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: moc),  user = NSManagedObject(entity: entity, insertIntoManagedObjectContext: moc) as? GPUser {
                user.username   = newUser.objectForKey(kGPUsername)    as! String
                user.password   = newUser.objectForKey(kGPPassword)    as! String
                user.email      = newUser.objectForKey(kGPEmail)       as! String
                user.userType   = newUser.objectForKey(kGPUsertype)    as! NSNumber
                user.plate      = newUser.objectForKey(kGPPlate)       as! String
                user.isCurrentUser =  false
                if let userCredit = newUser.objectForKey(kGPCredit) as? NSNumber {
                    user.balance = userCredit
                }
                else {
                    user.balance = NSNumber(integer: 0)
                }
            }
        }
    }
    
    func createNewParking(newParking: NSDictionary, moc: NSManagedObjectContext) {
        
        let parkingList = checkIfParkingExists(newParking.objectForKey(kGPParkingname) as! String)
        
        if parkingList.count > 0 {
            if let parking = parkingList.lastObject as? GPParking {
                parking.parkingName = newParking.objectForKey(kGPParkingname) as! String
                parking.price       = newParking.objectForKey(kGPPrice) as! NSNumber
            }
        }
        else {
            if let entity = NSEntityDescription.entityForName("Parking", inManagedObjectContext: moc),  parking = NSManagedObject(entity: entity, insertIntoManagedObjectContext: moc) as? GPParking {
                parking.parkingName = newParking.objectForKey(kGPParkingname) as! String
                parking.price       = newParking.objectForKey(kGPPrice) as! NSNumber
            }
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
    
    func getParkings() -> NSArray {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Parking")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let parkingsArray = fetchedResults {
            return parkingsArray
        }
        else {
            return []
        }
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
    
    func addBalance(value: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"isCurrentUser == YES")
        
        var error: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [GPUser]
        
        if let userArray = fetchedResults, currentUser = userArray.last {
            let oldBalance = currentUser.balance
            currentUser.balance = NSNumber(integer: oldBalance.integerValue + value)
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
    }
    
    func createParkingTicket(parkingObject: GPParking, plate: String, duration: Double, moc: NSManagedObjectContext) {
        let currentUser = getCurrentUser()
        
        if let entity = NSEntityDescription.entityForName("Ticket", inManagedObjectContext: moc),  ticket = NSManagedObject(entity: entity, insertIntoManagedObjectContext: moc) as? GPTicket {
            ticket.date     = NSDate()
            ticket.duration = NSNumber(double: duration)
            ticket.parking  = parkingObject
            ticket.user     = currentUser
        }
    }
    
    func createParkingPenality(parkingObject: GPParking, user: GPUser, amount: NSNumber = NSNumber(integer: 10), moc: NSManagedObjectContext) {
        
        if let entity = NSEntityDescription.entityForName("Penality", inManagedObjectContext: moc),  penality = NSManagedObject(entity: entity, insertIntoManagedObjectContext: moc) as? GPPenality {
            penality.paid = false
            penality.date = NSDate()
            penality.amount = amount
            penality.parking  = parkingObject
            penality.user     = user
        }
    }
    
    func getUserForPlate(plate: String) -> NSArray {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"plate == %@", plate)
        
        var error: NSError?
        
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [GPUser] {
            return fetchedResults
        }
        else {
            return []
        }
    }
    
    func removeParking(parking: GPParking)-> Bool {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Parking")
        fetchRequest.predicate = NSPredicate(format:"parkingName == %@", parking.parkingName)
        
        var error: NSError?
        
        if let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [GPParking] {
            for fetchedParking in fetchedResults  {
                managedContext.deleteObject(fetchedParking)
            }
            var error: NSError?
            if !managedContext.save(&error) {
                return false
            }
            else {
                return true
            }
        }
        else {
            return false
        }
    }
    
    func checkIfUserExists(username: String) -> NSArray {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"User")
        fetchRequest.predicate = NSPredicate(format:"username == %@", username)
        
        var importError: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &importError) as? [NSManagedObject]
        
        if let userList = fetchedResults {
            if userList.count != 0 {
                return userList
            }
            else {
                return []
            }
        }
        else {
            return []
        }
    }

    func checkIfParkingExists(parkingName: String) -> NSArray {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Parking")
        fetchRequest.predicate = NSPredicate(format:"parkingName == %@", parkingName)
        
        var importError: NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &importError) as? [NSManagedObject]
        
        if let parkingList = fetchedResults {
            if parkingList.count != 0 {
                return parkingList
            }
            else {
                return []
            }
        }
        else {
            return []
        }
    }
}