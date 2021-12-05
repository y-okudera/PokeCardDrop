//
//  PokeCardTableViewCell.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import UIKit
import Kingfisher

final class PokeCardTableViewCell: UITableViewCell {

    @IBOutlet private weak var pokeCardImageView: UIImageView!
    @IBOutlet private weak var noLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typesLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        pokeCardImageView.image = nil
    }

    func configure(pokeCard: PokeCard) {
        pokeCardImageView.kf.setImage(with: pokeCard.images.smallImageUrl)
        let no = pokeCard.nationalPokedexNumbers
            .map{ String($0) }
            .joined(separator: ",")
        noLabel.text = "No. " + no
        nameLabel.text = pokeCard.name
        typesLabel.text = pokeCard.types.joined(separator: ",")
    }
}
