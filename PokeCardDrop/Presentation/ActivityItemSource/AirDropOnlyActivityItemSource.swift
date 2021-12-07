//
//  AirDropOnlyActivityItemSource.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import UIKit
import LinkPresentation

final class AirDropOnlyActivityItemSource: NSObject {
    ///The item you want to send via AirDrop.
    let item: Any

    init(item: Any) {
        self.item = item
    }

    convenience init(pokeCard: PokeCard) {
        let data = Encoder.jsonData(from: pokeCard)
        self.init(item: data)
    }
}

extension AirDropOnlyActivityItemSource: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        //using NSURL here, since URL with an empty string would crash
        return NSURL(string: "")!
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        itemForActivityType activityType: UIActivity.ActivityType?
    ) -> Any? {
        return item
    }

    func activityViewController(
        _ activityViewController: UIActivityViewController,
        dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?
    ) -> String {
        return "jp.yuoku.PokeCardDropUTI.pokecard"
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let linkMetadata = LPLinkMetadata()
        linkMetadata.title = "Share pokemon card"

        let fileUrl = AssetExtractor.createLocalUrl(forImageNamed: "pokemon_tcg")
        linkMetadata.iconProvider = NSItemProvider(contentsOf: fileUrl)

        return linkMetadata
    }
}
