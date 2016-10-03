//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Luke Klepfer on 10/3/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
        
    }
    
}
