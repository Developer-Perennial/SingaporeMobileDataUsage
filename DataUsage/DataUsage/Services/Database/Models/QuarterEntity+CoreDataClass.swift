//
//  QuarterEntity+CoreDataClass.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//
//

import Foundation
import CoreData

@objc(QuarterEntity)
public class QuarterEntity: NSManagedObject {
    
    func save(id : Int?, name : String?,dataUsage : String?)
    {
        self.id =  Int16(id ?? 0)
        self.name = name
        self.dataUsage = dataUsage
    }
}
