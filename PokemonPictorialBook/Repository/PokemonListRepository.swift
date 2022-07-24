//
//  PokemonListRepository.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/18.
//

import Foundation
import PokemonAPI

struct PokemonListRepository {
    
    static func initFetch() async {
        if UserDefaults.standard.getBool(key: .initFetch) {
            return
        }
        await PokemonListRepository.fetch()
    }
    
    static func fetch() async {
        do {
            let result = try await PokemonAPI().pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 898))
            await Pokemon().add(result)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
