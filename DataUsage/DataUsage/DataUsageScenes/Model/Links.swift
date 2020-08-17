//
//  Links.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation
struct Links : Codable {
    let start : String?
    let next : String?

    enum CodingKeys: String, CodingKey {

        case start = "start"
        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        start = try values.decodeIfPresent(String.self, forKey: .start)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }

}
