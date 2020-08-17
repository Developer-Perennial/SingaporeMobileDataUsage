//
//  MocHelper.swift
//  DataUsageTests
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

@testable import DataUsage
import Foundation
class MockDataProvider {
    
    class func mockData(fileName: String = "DataUsage") throws -> DataUsageResponseDTO? {
        
        if let url = Bundle(for: self).url(forResource: fileName, withExtension: "json") {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(DataUsageResponseDTO.self, from: data)
            return jsonData
        }
        return nil
    }
}
