//
//  PokeCardsRepository.swift
//  PokeCardDrop
//
//  Created by Yuki Okudera on 2021/12/06.
//

import Foundation

// MARK: - Provider

enum PokeCardsRepositoryProvider {
    static func provide() -> PokeCardsRepository {
        return PokeCardsRepositoryImpl()
    }
}

// MARK: - protocol

protocol PokeCardsRepository {
    func pokeCards() -> PokeCards
}

// MARK: - Impl

private final class PokeCardsRepositoryImpl: PokeCardsRepository {
    func pokeCards() -> PokeCards {
        return AssetLoader.loadWithDecode(name: "cards")
    }
}
