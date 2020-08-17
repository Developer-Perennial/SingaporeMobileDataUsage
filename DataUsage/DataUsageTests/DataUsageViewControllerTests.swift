//
//  DataUsageViewControllerTests.swift
//  DataUsageTests
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import XCTest
import UIKit

@testable import DataUsage

class DataUsageViewControllerTests: XCTestCase {
    
    var viewController: DataUsageViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewController = storyboard.instantiateViewController(withIdentifier: "DataUsageViewController") as? DataUsageViewController
        let mocdata = try! MockDataProvider.mockData()
        viewController.viewModel =  DataUsageViewModel(dataProvider: DataUsageDataProvider(nwService: DataUsageNetworkService(), dbService: DataUsageDBService()))
        let viewModel = viewController.viewModel as? DataUsageViewModel
        viewModel?.assignYearlyData(dataUsageRecords: mocdata?.result?.records)
        
        self.viewController.loadView()
        self.viewController.viewDidLoad()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        
        
        XCTAssertTrue(viewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.numberOfSections(in:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:viewForHeaderInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewCellHasReuseIdentifier() {
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? DataUsageTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "DataUsageTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testhasConfirmProtocal()
    {
        XCTAssertNotNil(viewController.showError(message: ""))
        XCTAssertNotNil(viewController.dismissActivityIndicator)
        XCTAssertNotNil(viewController.showActivityIndicator)
        XCTAssertNotNil(viewController.presentData)
        XCTAssertNotNil(viewController.reloadImageViewCell)
        XCTAssertNotNil(viewController.imageViewClicked)
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
}
