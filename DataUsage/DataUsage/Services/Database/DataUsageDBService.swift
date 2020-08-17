//
//  DataUsageDBService.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

protocol DataBaseServiceProtocol : class {
    
    func saveQuarterData   ( records : [Records])
    func fetchQuarterData  ( ) -> [Records]
    func deleteQuarterData ( ) -> Bool
}

class DataUsageDBService : DataBaseServiceProtocol
{
    func saveQuarterData(records : [Records])
    {
        for record in records
        {
            let quarterEntity = DataBaseHandler.shared.createManagedObject(tableName: "QuarterEntity") as? QuarterEntity
            quarterEntity?.save(id:record.id,name:record.quarter,dataUsage:record.volume_of_mobile_data)
        }
        let _ = DataBaseHandler.shared.saveContext()
    }
    
    func fetchQuarterData() -> [Records]
    {
        let sort = NSSortDescriptor(key: #keyPath(QuarterEntity.name), ascending: true)
        let values = DataBaseHandler.shared.fetchData(tableName: "QuarterEntity", predicate: nil, sortDiscriptor: sort)
        guard let recordsDBValue = values as? [QuarterEntity] else {
            return [Records]()
        }
        var records = [Records]()
        for dbRecord in recordsDBValue
        {
            records.append(Records.init(id: Int(dbRecord.id), name: dbRecord.name, dataUdage: dbRecord.dataUsage))
        }
        return records
    }
    
    func deleteQuarterData() -> Bool
    {
        let result = DataBaseHandler.shared.deleteRecord(tableName: "QuarterEntity", predicate: nil)
        let _ = DataBaseHandler.shared.saveContext()
        return result
    }
}
