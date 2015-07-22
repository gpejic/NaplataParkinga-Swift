//
//  GPUser.swift
//  
//
//  Created by Goran Pejic on 19/07/15.
//
//

import Foundation
import CoreData

@objc(GPUser)
class GPUser: NSManagedObject {

    @NSManaged var username         : String
    @NSManaged var password         : String
    @NSManaged var email            : String
    @NSManaged var userType         : String
    @NSManaged var budget           : NSNumber
    @NSManaged var penality         : NSNumber
}
