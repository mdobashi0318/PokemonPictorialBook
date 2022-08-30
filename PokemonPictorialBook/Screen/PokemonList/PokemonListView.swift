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
                    pokemonList(region: "カントー地方", model: viewModel.kanto)
                    pokemonList(region: "ジョウト地方", model: viewModel.johto)
                    pokemonList(region: "ホウエン地方", model: viewModel.hoenn)
                    pokemonList(region: "シンオウ地方", model: viewModel.sinnoh)
                    pokemonList(region: "イッシュ地方", model: viewModel.unova)
                    pokemonList(region: "カロス地方", model: viewModel.kalos)
                    pokemonList(region: "アローラ地方", model: viewModel.alola)
                    pokemonList(region: "ガラル地方", model: viewModel.galar)
                }
                .tabViewStyle(PageTabViewStyle())
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
    
    
    private func pokemonList(region: String, model: [Pokemon]) -> some View {
        Section (content: {
            VStack {
                /// Sectionのヘッダーにテキストを入れたいが、ページがヘッダー → リスト → ヘッダー → リスト という形になってしまうのでVStackでヘッダーを作る
                HStack{
                    Text(region)
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                List(0..<model.count, id: \.self) { row in
                    NavigationLink(destination: {
                        PokemonDetail(pokemon: model[row])
                    }) {
                        PokemonListRow(name: model[row].name ?? "")
                    }
                }
            }
        })
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
