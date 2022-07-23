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
    
    @objc dynamic var keyName: String = ""
    
    /// The default depiction of this Pokémon from the front in battle
    @objc dynamic var frontDefault: String?
    
    /// The shiny depiction of this Pokémon from the front in battle
    @objc dynamic var frontShiny: String?
    
    /// The female depiction of this Pokémon from the front in battle
    @objc dynamic var frontFemale: String?
    
    /// The shiny female depiction of this Pokémon from the front
    @objc dynamic var frontShinyFemale: String?
    
    /// The default depiction of this Pokémon from the back in battle
    @objc dynamic var backDefault: String?
    
    /// The shiny depiction of this Pokémon from the back in battle
    @objc dynamic var backShiny: String?
    
    /// The female depiction of this Pokémon from the back in battle
    @objc dynamic var backFemale: String?
    
    /// The shiny female depiction of this Pokémon from the back in battle
    @objc dynamic var backShinyFemale: String?
    
    //
    //
    //    override static func primaryKey() -> String? {
    //        return "name"
    //    }
    
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
    
    
    func fetch(_ name: String) -> PokemonSprites? {
        guard let realm = PokemonSprites.realm else {
            return nil
        }
        let predicate = NSPredicate(format: "keyName == %@", name)
        return realm.objects(PokemonSprites.self).filter(predicate).first
    }
}


