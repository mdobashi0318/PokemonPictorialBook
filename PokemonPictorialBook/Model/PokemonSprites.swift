//
//  PokemonSprites.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/19.
//

import Foundation
import RealmSwift
import PokemonAPI

/// Pokemon Sprites
class PokemonSprites: Object {
    
    
    // MARK: private
    
    @objc dynamic private var keyName: String = ""
    
    /// The default depiction of this Pokémon from the front in battle
    @objc dynamic private var frontDefault: String?
    
    /// The shiny depiction of this Pokémon from the front in battle
    @objc dynamic private var frontShiny: String?
    
    /// The female depiction of this Pokémon from the front in battle
    @objc dynamic private var frontFemale: String?
    
    /// The shiny female depiction of this Pokémon from the front
    @objc dynamic private var frontShinyFemale: String?
    
    /// The default depiction of this Pokémon from the back in battle
    @objc dynamic private var backDefault: String?
    
    /// The shiny depiction of this Pokémon from the back in battle
    @objc dynamic private var backShiny: String?
    
    /// The female depiction of this Pokémon from the back in battle
    @objc dynamic private var backFemale: String?
    
    /// The shiny female depiction of this Pokémon from the back in battle
    @objc dynamic private var backShinyFemale: String?
    
    
    /// Realmのインスタンス化
    private static var realm: Realm? {
        let realm: Realm
        var configuration: Realm.Configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(1)
        do {
            realm = try Realm(configuration: configuration)
            return realm
        } catch {
            return nil
        }
    }
    
    
    
    // MARK: internal
    
    /// ポケモンの画像
    static let getFrontDefault = { (name: String?) -> URL in
        return URL(string: PokemonSprites.fetch(name ?? "")?.frontDefault ?? "")!
    }
    
    
    func add(_ pokemon: PKMPokemon) {
        do {
            guard let realm = PokemonSprites.realm else {
                return
            }
            let sprites = PokemonSprites()
            sprites.keyName = pokemon.name!
            sprites.frontDefault = pokemon.sprites?.frontDefault
            sprites.frontFemale = pokemon.sprites?.frontFemale
            sprites.backDefault = pokemon.sprites?.backDefault
            sprites.backShiny = pokemon.sprites?.backShiny
            realm.beginWrite()
            realm.add(sprites)
            try realm.commitWrite()
        } catch(_) {
            print()
        }
    }
    
    
    static func fetch(_ name: String) -> PokemonSprites? {
        guard let realm = PokemonSprites.realm else {
            return nil
        }
        let predicate = NSPredicate(format: "keyName == %@", name)
        return realm.objects(PokemonSprites.self).filter(predicate).first
    }
}


