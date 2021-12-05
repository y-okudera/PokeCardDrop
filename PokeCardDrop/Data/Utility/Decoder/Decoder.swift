//
//  Decoder.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import Foundation

enum Decoder {

    /// Json decoding
    static func jsonDecode<T: Decodable>(from data: Data) -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Decoding failure. error: \(error)")
        }
    }
}
