//
//  PokemonDetail.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/21.
//

import SwiftUI
import Kingfisher

struct PokemonDetail: View {
    
    let name: String
    
    let url: String
    
    var body: some View {
        VStack {
            KFImage.url(URL(string: url))
                .placeholder({
                    ProgressView()
                })
                .cancelOnDisappear(true)
            Text(name)
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(name: "bulbasaur", url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
}
