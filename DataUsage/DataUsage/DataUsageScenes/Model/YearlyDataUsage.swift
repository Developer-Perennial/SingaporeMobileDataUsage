//
//  YearlyDataUsage.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

struct YearlyDataUsage  {

    var name: String?
    var usedData : Double?
    var isDecresedData : Bool = false
    var isMessageVisiable = false
    
    mutating func changeMessageVisiableStatus()
    {
        isMessageVisiable = !isMessageVisiable
    }
}
