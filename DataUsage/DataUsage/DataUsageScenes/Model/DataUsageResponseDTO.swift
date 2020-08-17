//
//  DataUsageResponseDTO.swift
//  DataUsage
//
//  Created by Pravin Jadhao on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation
struct DataUsageResponseDTO : Codable {
    let help : String?
    let success : Bool?
    let result : ResultData?

    enum CodingKeys: String, CodingKey {

        case help = "help"
        case success = "success"
        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        help = try values.decodeIfPresent(String.self, forKey: .help)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        result = try values.decodeIfPresent(ResultData.self, forKey: .result)
    }

}
