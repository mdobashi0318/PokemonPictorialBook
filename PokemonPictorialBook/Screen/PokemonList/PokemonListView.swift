//
//  PokemonListView.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/16.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                VStack(alignment: .center, spacing: 30) {
                    ProgressView()
                    Text("データを取得しています。\n少々お待ちください。")
                        .multilineTextAlignment(.center)
                }
            } else {
                TabView {
                    pokemonList(model: viewModel.kanto)
                        .tabItem {
                            Label("カントー", systemImage: "list.bullet")
                        }
                    pokemonList(model: viewModel.johto)
                        .tabItem {
                            Label("ジョウト", systemImage: "list.bullet")
                        }
                    pokemonList(model: viewModel.hoenn)
                        .tabItem {
                            Label("ホウエン", systemImage: "list.bullet")
                        }
                    pokemonList(model: viewModel.sinnoh)
                        .tabItem {
                            Label("シンオウ", systemImage: "list.bullet")
                        }
                    pokemonList(model: viewModel.unova)
                        .tabItem {
                            Label("イッシュ", systemImage: "list.bullet")
                        }
                    pokemonList(model: viewModel.kalos)
                        .tabItem {
                            Label("カロス", systemImage: "list.bullet")
                        }
                    pokemonList(model: viewModel.alola)
                        .tabItem {
                            Label("アローラ", systemImage: "list.bullet")
                        }
                    pokemonList( model: viewModel.galar)
                        .tabItem {
                            Label("ガラル", systemImage: "list.bullet")
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
    
    
    private func pokemonList(model: [Pokemon]) -> some View {
        List(0..<model.count, id: \.self) { row in
            NavigationLink(destination: {
                PokemonDetail(pokemon: model[row])
            }) {
                PokemonListRow(name: model[row].name ?? "")
            }
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
