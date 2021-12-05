//
//  ReceivedPokeCardRepository.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/06.
//

import Foundation

// MARK: - Provider

enum ReceivedPokeCardRepositoryProvider {
    static func provide() -> ReceivedPokeCardRepository {
        return ReceivedPokeCardRepositoryImpl()
    }
}

// MARK: - protocol

protocol ReceivedPokeCardRepository {
    func read() -> PokeCard?
    func write(receivedPokeCard: PokeCard)
    func delete()
}

// MARK: - Impl

private final class ReceivedPokeCardRepositoryImpl: ReceivedPokeCardRepository {
    func read() -> PokeCard? {
        return ReceivedPokeCardStore.shared.pokeCard
    }

    func write(receivedPokeCard: PokeCard) {
        ReceivedPokeCardStore.shared.pokeCard = receivedPokeCard
    }

    func delete() {
        ReceivedPokeCardStore.shared.pokeCard = nil
    }
}

private final class ReceivedPokeCardStore {
    static let shared = ReceivedPokeCardStore()

    var pokeCard: PokeCard?

    private init() {}
}
