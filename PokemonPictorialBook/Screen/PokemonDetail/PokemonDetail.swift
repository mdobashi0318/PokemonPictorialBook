//
//  PokemonDetail.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/21.
//

import SwiftUI
import Kingfisher

struct PokemonDetail: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            KFImage.url(PokemonSprites.getFrontDefault(pokemon.name))
                .placeholder({
                    ProgressView()
                })
                .cancelOnDisappear(true)
            Text(pokemon.name ?? "")
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: Pokemon())
    }
}
