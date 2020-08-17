//
//  DataUsageRequestDTO.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

struct DataUsageRequestDTO : Codable {
    let resourceId : String?
    let limit : Int?

    enum CodingKeys: String, CodingKey {
        case resourceId = "resource_id"
        case limit = "limit"
    }
    public init(resourceId : String, limit : Int?) {
        self.resourceId = resourceId
        self.limit = limit
    }
}
