//
//  JSONEncoder.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import Foundation

enum Encoder {

    /// Json encoding
    static func jsonString<T: Encodable>(from encodableData: T) -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(encodableData)
#if DEBUG
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
#endif
            return data
        } catch {
            fatalError("Encoding failure. error: \(error)")
        }
    }
}
