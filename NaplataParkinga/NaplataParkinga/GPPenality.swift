//
//  GPPenality.swift
//  NaplataParkinga
//
//  Created by Goran Pejic on 27/09/15.
//  Copyright (c) 2015 Goran Pejic. All rights reserved.
//

import Foundation
import CoreData

@objc(GPPenality)
class GPPenality: NSManagedObject {

    @NSManaged var amount: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var paid: NSNumber
    @NSManaged var user: GPUser
    @NSManaged var parking: GPParking
}
