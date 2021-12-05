//
//  AssetLoader.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import UIKit

final class AssetLoader {
    static func loadWithDecode<T: Decodable>(
        name: String,
        decoder: () -> JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }
    ) -> T {
        guard let dataAsset = NSDataAsset(name: name, bundle: .init(for: self)) else {
            fatalError("Asset data loading failure.")
        }
        do {
            return try decoder().decode(T.self, from: dataAsset.data)
        } catch {
            fatalError("Decoding failure. error: \(error)")
        }
    }
}
