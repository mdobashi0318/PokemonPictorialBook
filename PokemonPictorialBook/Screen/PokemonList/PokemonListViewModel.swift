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
    @Published var kanto: [Pokemon] = []
    
    @Published var johto: [Pokemon] = []
    
    @Published var hoenn: [Pokemon] = []
    
    @Published var sinnoh: [Pokemon] = []
    
    @Published var unova: [Pokemon] = []
    
    @Published var kalos: [Pokemon] = []
    
    @Published var alola: [Pokemon] = []
    
    @Published var galar: [Pokemon] = []
    
    
    
    /// リストに格納するデータをDBから取得
    func setModel () {
        kanto = Pokemon().findKanto()
        johto = Pokemon().findJohto()
        hoenn = Pokemon().findHoenn()
        sinnoh = Pokemon().findSinnoh()
        unova = Pokemon().findUnova()
        kalos = Pokemon().findKalos()
        alola = Pokemon().findAlola()
        galar = Pokemon().findGalar()
    }
}
