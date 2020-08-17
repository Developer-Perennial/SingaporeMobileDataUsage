//
//  DataUsageDataProvider.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

protocol DataProviderServiceProtocol  {
    
    func getDataUsageInfo(requestDTO : DataUsageRequestDTO,completion:@escaping (Result<[Records]?, APIError>) -> Void)
}

class DataUsageDataProvider : DataProviderServiceProtocol
{
    let nwService : NetworkServiceProtocol!
    let dbService : DataBaseServiceProtocol!
    init(nwService:NetworkServiceProtocol,dbService : DataBaseServiceProtocol) {
        self.nwService = nwService
        self.dbService = dbService
    }
    
    func getDataUsageInfo(requestDTO : DataUsageRequestDTO,completion:@escaping (Result<[Records]?, APIError>) -> Void)
    {
        let param = Helper.getJSONObject(obj:requestDTO)
        nwService.request(url: ApiPath.MOBILE_DATA_USAGE, method: .get, parameters: param, headers: [:], uRLEncoding: .default) { (result: Result<DataUsageResponseDTO, APIError>) in
            switch result {
            case .success(let model):
                let _ = self.dbService.deleteQuarterData()
                self.dbService.saveQuarterData(records: model.result?.records ?? [])
                completion(.success(model.result?.records))
            case .failure(let error):
                if error.internetNotAvailble {
                    completion(.success(self.dbService.fetchQuarterData()))
                }else{
                    completion(.failure(error))
                }
            }
        }
    }
}
