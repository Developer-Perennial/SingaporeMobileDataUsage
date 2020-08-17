//
//  DataBaseServiceTests.swift
//  DataUsageTests
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

import XCTest

@testable import DataUsage


class DataBaseServiceTests: XCTestCase {
    
    var dbService : DataBaseServiceProtocol!
    
    override func setUp() {
        super.setUp()
        dbService = DataUsageDBService()
        let _ = dbService.deleteQuarterData()
    }
    
    func testInsertData()
    {
        let mocdata = try! MockDataProvider.mockData()
        let count = mocdata?.result?.records?.count ?? 0
        dbService.saveQuarterData(records: mocdata?.result?.records ?? [])
        XCTAssertEqual(count, dbService.fetchQuarterData().count)
    }
    
    func testFetchData()
    {
        let mocdata = try! MockDataProvider.mockData()
        dbService.saveQuarterData(records: mocdata?.result?.records ?? [])
        let records = dbService.fetchQuarterData()
        XCTAssertNotNil(mocdata?.result?.records)
        let record1 = mocdata!.result!.records![0]
        let record2 = records[0]
        
        XCTAssertEqual(record1.id, record2.id)
        XCTAssertEqual(record1.quarter, record2.quarter)
        XCTAssertEqual(record1.volume_of_mobile_data, record2.volume_of_mobile_data)
    }
    
    func testDeleteData()
    {
        let mocdata = try! MockDataProvider.mockData()
        let count = mocdata?.result?.records?.count ?? 0
        dbService.saveQuarterData(records: mocdata?.result?.records ?? [])
        let _ = dbService.deleteQuarterData()
        XCTAssertNotEqual(count, dbService.fetchQuarterData().count)
    }
    
    override func tearDown() {
        super.tearDown()
        let _ = dbService.deleteQuarterData()
    }
}
