//
//  GPParking.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 27/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import CoreData

@objc(GPParking)
class GPParking: NSManagedObject {

    @NSManaged var parkingName: String
    @NSManaged var price: NSNumber
    @NSManaged var ticket: NSSet

}
