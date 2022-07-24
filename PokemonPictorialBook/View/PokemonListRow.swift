//
//  PokemonListRow.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/24.
//

import SwiftUI
import Kingfisher


struct PokemonListRow: View {
    @State var name: String
    @State var image: String
    
    var body: some View {
        HStack {
            KFImage.url(URL(string: image)!)
                .placeholder({
                    ProgressView()
                })
                .cancelOnDisappear(true)
            Text(name)
        }
    }
}

struct PokemonListRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListRow(name: "name", image: "image")
    }
}
