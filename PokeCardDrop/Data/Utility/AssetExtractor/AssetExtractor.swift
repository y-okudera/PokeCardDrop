//
//  AssetExtractor.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/06.
//

import UIKit

enum AssetExtractor {
    static func createLocalUrl(forImageNamed name: String) -> URL? {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")

        guard FileManager.default.fileExists(atPath: url.path) else {
            guard let data = UIImage(named: name)?.pngData() else {
                return nil
            }

            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
        return url
    }
}
