//
//  NetworkServiceTests.swift
//  DataUsageTests
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import XCTest
import Alamofire

@testable import DataUsage

class NetworkServiceTests: XCTestCase {
    
    var nwService : NetworkServiceProtocol!
    override func setUp() {
        super.setUp()
        nwService = MocDataUsageNetworkService()
    }
    
    func testBaseUrl()
    {
        XCTAssertEqual(Configuration.BASE_URL, "https://data.gov.sg/api/")
    }
    func testApiPath()
    {
        XCTAssertEqual(ApiPath.MOBILE_DATA_USAGE, "action/datastore_search")
    }
    
    func testGetData()
    {
        let promise = expectation(description: "success = true")
        let requestDTO = DataUsageRequestDTO.init(resourceId: Configuration.resourceID, limit: 1000)
        let param = Helper.getJSONObject(obj: requestDTO)
        nwService.request(url: ApiPath.MOBILE_DATA_USAGE, method: .get, parameters: param, headers: [:], uRLEncoding: .default) { (result: Result<DataUsageResponseDTO, APIError>) in
            switch result{
            case .success(let dto):
                XCTAssertNotNil(dto)
            case .failure(let error):
                XCTAssertNil(error)
                break;
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 15)
    }
    
    func testParseError()
    {
        if let ser = nwService as? MocDataUsageNetworkService {
            ser.fileName = "ParsingError"
        }
        let promise = expectation(description: "success = true")
        let requestDTO = DataUsageRequestDTO.init(resourceId: Configuration.resourceID, limit: 1000)
        let param = Helper.getJSONObject(obj: requestDTO)
        nwService.request(url: ApiPath.MOBILE_DATA_USAGE, method: .get, parameters: param, headers: [:], uRLEncoding: .default) { (result: Result<DataUsageResponseDTO, APIError>) in
            
            switch result{
            case .success(let dto):
                XCTAssertNil(dto)
            case .failure(let error):
                XCTAssertNotNil(error.parseError)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 15)
    }
    
    func testInternetNotAvailable()
    {
        if let ser = nwService as? MocDataUsageNetworkService {
            ser.isIntenetAvailable = false
        }
        let promise = expectation(description: "success = true")
        let requestDTO = DataUsageRequestDTO.init(resourceId: Configuration.resourceID, limit: 1000)
        let param = Helper.getJSONObject(obj: requestDTO)
        nwService.request(url: ApiPath.MOBILE_DATA_USAGE, method: .get, parameters: param, headers: [:], uRLEncoding: .default) { (result: Result<DataUsageResponseDTO, APIError>) in
            switch result{
            case .success(let dto):
                XCTAssertNil(dto)
            case .failure(let error):
                XCTAssertTrue(error.internetNotAvailble)
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 15)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

class MocDataUsageNetworkService : NetworkServiceProtocol
{
    var fileName = "DataUsage"
    var isIntenetAvailable = true
    func request<T>(url: String, method: HTTPMethod, parameters: [String : Any]?, headers: HTTPHeaders, uRLEncoding: URLEncoding, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        if !isIntenetAvailable{
            completion(.failure(APIError.init(parseError: nil, error: nil, data: nil, internetNotAvailble: !isIntenetAvailable)))
            return
        }
        do{
            let mocData = try MockDataProvider.mockData(fileName: fileName)
            completion(.success(mocData as! T))
        }catch{
            let parseError = ParseError(error, file: #file, line: #line, function: #function)
            completion(.failure(APIError.init(parseError: parseError, error: error, data: nil, internetNotAvailble: false)))
        }
    }
}
