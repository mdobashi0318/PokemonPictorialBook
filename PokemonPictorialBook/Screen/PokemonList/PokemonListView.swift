//
//  PokemonListView.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/16.
//

import SwiftUI
import Kingfisher

struct PokemonListView: View {
    
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List(0..<viewModel.pokemonList.count, id: \.self) { row in
                    NavigationLink(destination: {
                        PokemonDetail(name: viewModel.pokemonList[row].name ?? "", url: viewModel.frontDefault(viewModel.pokemonList[row].name))
                    }) {
                        rowViwe(row)
                    }
                }
                .navigationTitle("ポケモン図鑑")
            }
        }
        .task {
            viewModel.isLoading = true
            await PokemonListRepository.initFetch()
            viewModel.setModel()
            viewModel.isLoading = false
        }
    }
    
    private func rowViwe(_ row: Int) -> some View {
        HStack {
            KFImage.url(URL(string: viewModel.frontDefault(viewModel.pokemonList[row].name)))
                .placeholder({
                    ProgressView()
                })
                .cancelOnDisappear(true)
            Text(viewModel.pokemonList[row].name ?? "")
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
