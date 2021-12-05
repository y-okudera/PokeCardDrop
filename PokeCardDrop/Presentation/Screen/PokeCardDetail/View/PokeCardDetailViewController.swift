//
//  PokeCardDetailViewController.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/06.
//

import UIKit
import Kingfisher

final class PokeCardDetailViewController: UIViewController {

    static func build(pokeCard: PokeCard) -> UIViewController {
        let storyboard = UIStoryboard(name: "PokeCardDetailViewController", bundle: .init(for: self))
        let vc = storyboard.instantiateViewController(withIdentifier: "PokeCardDetailViewController") as! PokeCardDetailViewController
        vc.pokeCard = pokeCard
        return vc
    }

    @IBOutlet private weak var pokeCardImageView: UIImageView!

    private var pokeCard: PokeCard!

    override func viewDidLoad() {
        super.viewDidLoad()
        pokeCardImageView.kf.setImage(with: pokeCard.images.largeImageUrl)
    }
    
    @IBAction private func tappedShareButton(_ sender: UIButton) {
        let itemSource = AirDropOnlyActivityItemSource(pokeCard: pokeCard)
        let activityVc = UIActivityViewController(activityItems: [itemSource], applicationActivities: nil)
        present(activityVc, animated: true)
    }
}
