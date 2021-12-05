//
//  PokeCardListViewController.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/05.
//

import UIKit
import Toast

final class PokeCardListViewController: UIViewController {

    static func build(pokeCards: PokeCards) -> UIViewController {
        let storyboard = UIStoryboard(name: "PokeCardListViewController", bundle: .init(for: self))
        let vc = storyboard.instantiateViewController(withIdentifier: "PokeCardListViewController") as! PokeCardListViewController
        vc.pokeCards = pokeCards
        return vc
    }

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.dataSource = self
            newValue.delegate = self
            newValue.register(
                UINib(
                    nibName: PokeCardTableViewCell.identifier,
                    bundle: .init(for: type(of: self))
                ),
                forCellReuseIdentifier: PokeCardTableViewCell.identifier
            )
        }
    }

    private var pokeCards: PokeCards!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "PokeCards"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let receivedPokeCardRepository = ReceivedPokeCardRepositoryProvider.provide()
        if let receivedPokeCard = receivedPokeCardRepository.read() {
            receivedPokeCardRepository.delete()
            presentPokeCardDetail(pokeCard: receivedPokeCard, toastMessage: "Received \(receivedPokeCard.name) via AirDrop.")
        }
    }

    private func presentPokeCardDetail(pokeCard: PokeCard) {
        let vc = PokeCardDetailViewController.build(pokeCard: pokeCard)
        present(vc, animated: true)
    }

    private func presentPokeCardDetail(pokeCard: PokeCard, toastMessage: String) {
        let vc = PokeCardDetailViewController.build(pokeCard: pokeCard)
        present(vc, animated: true) {
            vc.view.makeToast(toastMessage, position: .top)
        }
    }
}

// MARK: - UITableViewDataSource
extension PokeCardListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokeCards.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokeCardTableViewCell.identifier, for: indexPath) as! PokeCardTableViewCell
        cell.configure(pokeCard: pokeCards.data[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PokeCardListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentPokeCardDetail(pokeCard: pokeCards.data[indexPath.row])
    }
}
