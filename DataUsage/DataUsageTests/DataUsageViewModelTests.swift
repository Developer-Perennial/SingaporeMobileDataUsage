//
//  DataUsageViewModelTests.swift
//  DataUsageTests
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import XCTest

@testable import DataUsage

class DataUsageViewModelTests: XCTestCase {
    
    var viewModel: DataUsageViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = DataUsageViewModel(dataProvider: DataUsageDataProvider(nwService: DataUsageNetworkService(), dbService: DataUsageDBService()))
    }
    
    private func setMocData()
    {
        let mocdata = try! MockDataProvider.mockData()
        viewModel.assignYearlyData(dataUsageRecords: mocdata?.result?.records)
    }
    
    func test_screenTitle() {
        XCTAssertEqual(viewModel.getScreenTitle(), "Data Usage","Title should be same")
    }
    
    func test_numberOfSection()  {
        
        XCTAssertEqual(viewModel.getNumberOfSection(), 1,"Section should be 1")
    }
    
    func test_headerData(){
        
        let headerData = viewModel.getHeaderData()
        XCTAssertEqual(headerData.0, "Year","Header title should be Year")
        XCTAssertEqual(headerData.1, "Total data Usage","Header data should be match")
    }
    
    func test_numberOfRow() {
        setMocData()
        XCTAssertEqual(viewModel.getNumberOfRow(),13,"Should get 13 records")
    }
    
    func test_yearlyDataForRow() {
        setMocData()
        let yearlyData = viewModel.yearlyData(index: 0)
        XCTAssertEqual(yearlyData.0,"2016","Year title should be 2016")
        XCTAssertEqual(yearlyData.1,"47.361280","Data usage not match")
    }
    func test_ImageStatus() {
        setMocData()
        var yearlyData = viewModel.getImageStatus(index: 0)
        XCTAssertFalse(yearlyData.0)
        yearlyData = viewModel.getImageStatus(index: 1)
        XCTAssertTrue(yearlyData.0)
    }
    
    func test_changeImageStatus() {
        setMocData()
        viewModel.changeImageStatus(section: 0, row: 1)
        let yearlyData = viewModel.getImageStatus(index: 1)
        XCTAssertTrue(yearlyData.0,"Image status not changes")
        XCTAssertTrue(yearlyData.1)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
}

