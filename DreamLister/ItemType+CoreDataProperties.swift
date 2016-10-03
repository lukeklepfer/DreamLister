//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Luke Klepfer on 10/3/16.
//  Copyright © 2016 Luke. All rights reserved.
//

import Foundation
import CoreData
//import

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
