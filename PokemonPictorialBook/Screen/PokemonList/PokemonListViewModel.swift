//
//  PokemonListViewModel.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/19.
//

import Foundation


class PokemonListViewModel: ObservableObject {
    
    /// プログレスビューの表示フラグ
    @Published var isLoading = false
    
    /// ポケモンリスト
    @Published var pokemonList: [Pokemon] = []
    
    /// 表示したいポケモンの画像
    let frontDefault = { (name: String?) -> String in
        return PokemonSprites().fetch(name ?? "")?.frontDefault ?? ""
    }
    
    
    
    /// リストに格納するデータをDBから取得
    func setModel () {
        pokemonList = Pokemon().findAll()
    }
}
