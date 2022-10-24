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
                .resizable()
                .frame(width: 300, height: 300)
            Text(pokemon.name ?? "")
            HStack {
                
                HStack {
                    Text("Height : ")
                    Text("\(String(format: "%.1f", (Float(pokemon.height) * Float(100)) / Float(1000)))m")
                }
                HStack {
                    Text("Weight : ")
                    Text("\(String(format: "%.1f", (Float(pokemon.weight) * Float(100)) / Float(1000)))kg")
                }
            }
            .padding()
            Spacer()
            
        }
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(pokemon: Pokemon())
    }
}
