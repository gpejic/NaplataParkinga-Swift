//
//  GPUser.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 27/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import CoreData

@objc(GPUser)
class GPUser: NSManagedObject {

    @NSManaged var balance: NSNumber
    @NSManaged var email: String
    @NSManaged var isCurrentUser: NSNumber
    @NSManaged var password: String
    @NSManaged var username: String
    @NSManaged var userType: NSNumber
    @NSManaged var plate: String
    @NSManaged var ticket: NSSet
    @NSManaged var penality: NSSet

}
