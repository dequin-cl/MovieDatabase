//
//  APIKeys.swift
//  MovieDatabase
//
//  Created by Iván GalazJeria on 31-05-20.
//  Copyright © 2020 dqn. All rights reserved.
//

import Foundation

struct APIKeys: Codable {
    var authV4: String
    var authV3: String
}

class APIKeysLoader {
    static func loadKeys() -> APIKeys {

        let path = Bundle.main.path(forResource: "keys", ofType: "plist")!
        let url = URL(fileURLWithPath: path)

        let decoder = PropertyListDecoder()

        guard let data = try? Data(contentsOf: url),
            let keys = try? decoder.decode(APIKeys.self, from: data)
            else { return APIKeys(authV4: "", authV3: "") }

        return keys
    }
}

