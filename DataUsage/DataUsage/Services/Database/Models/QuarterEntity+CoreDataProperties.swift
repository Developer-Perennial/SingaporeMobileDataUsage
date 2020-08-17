//
//  QuarterEntity+CoreDataProperties.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//
//

import Foundation
import CoreData


extension QuarterEntity {

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var dataUsage: String?

}
