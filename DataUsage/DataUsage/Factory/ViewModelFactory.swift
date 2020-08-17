//
//  ViewModelFactory.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation


enum ViewModelType {
   case dataUsage
}

class ViewModelFactory {
    
    static func getViewModel(type: ViewModelType) -> BaseViewModel? {
        switch type {
        case .dataUsage:
            let dbService = DataUsageDBService()
            let nwService = DataUsageNetworkService()
            let dataProvider = DataUsageDataProvider(nwService: nwService, dbService: dbService)
            let mobileDataUsage = DataUsageViewModel(dataProvider: dataProvider)
            return mobileDataUsage
        }
    }
}
