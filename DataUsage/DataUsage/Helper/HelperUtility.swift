//
//  HelperUtility.swift
//  DataUsage
//
//  Created by Pere-Dev on 17/08/20.
//  Copyright © 2020 Perennial System. All rights reserved.
//

import Foundation

struct Helper {
    
    public static func getJSONObject<T : Encodable>(obj : T)->[String : Any]?{
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do{
            let jsonData = try jsonEncoder.encode(obj)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
            return json as? [String : Any]
        }
        catch{
            return nil
        }
    }
}
