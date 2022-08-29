//
//  Pokemon.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/18.
//

import Foundation
import RealmSwift
import PokemonAPI



class Pokemon: Object {
    
    /// Realmのインスタンス化
    static var realm: Realm? {
        let realm: Realm
        var configuration: Realm.Configuration = Realm.Configuration()
        configuration.schemaVersion = UInt64(1)
        do {
            realm = try Realm(configuration: configuration)
            return realm
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// The identifier for this Pokémon resource
    @objc dynamic var id: Int = 0
    
    /// The name for this Pokémon resource
    @objc dynamic var name: String?
    
    /// The base experience gained for defeating this Pokémon
    @objc dynamic var baseExperience: Int = 0
    
    /// The height of this Pokémon
    @objc dynamic var height: Int = 0
    
    /// Set for exactly one Pokémon used as the default for each species
    //    @objc dynamic var isDefault: Bool?
    
    /// Order for sorting. Almost national order, except families are grouped together.
    @objc dynamic var order: Int = 0
    
    /// The weight of this Pokémon
    @objc dynamic var weight: Int = 0
    
    /// A list of abilities this Pokémon could potentially have
    //    var abilities: [PKMPokemonAbility]?
    
    /// A list of forms this Pokémon can take on
    //    var forms: [PKMNamedAPIResource<PKMPokemonForm>]?
    
    /// A list of game indices relevent to Pokémon item by generation
    //    var gameIndices: [PKMVersionGameIndex]?
    
    /// A list of items this Pokémon may be holding when encountered
    //    var heldItems: [PKMPokemonHeldItem]?
    
    /// A list of location areas as well as encounter details pertaining to specific versions
    @objc dynamic var locationAreaEncounters: String?
    
    /// A list of moves along with learn methods and level details pertaining to specific version groups
    //    var moves: [PKMPokemonMove]?
    
    /// A set of sprites used to depict this Pokémon in the game
    @objc dynamic var sprites: PokemonSprites?
    
    /// The species this Pokémon belongs to
    //    var species: PKMNamedAPIResource<PKMPokemonSpecies>?
    
    /// A list of base stat values for this Pokémon
    //    var stats: [PKMPokemonStat]?
    
    /// A list of details showing types this Pokémon has
    //    var types: [PKMPokemonType]?
    
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    
    func findKanto() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id <= 151")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    func findJohto() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 152 && id <= 251")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    
    
    func findHoenn() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 252 && id <= 386")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    func findSinnoh() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 387 && id <= 493")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    func findUnova() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 494 && id <= 649")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    func findKalos() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 650 && id <= 721")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    func findAlola() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 722 && id <= 809")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    func findGalar() -> [Pokemon] {
        var result: [Pokemon] = []
        guard let realm = Pokemon.realm else {
            return []
        }
        
        
        let predicate = NSPredicate(format: "id >= 810 && id <= 890")
        realm.objects(Pokemon.self).filter(predicate).forEach {
            result.append($0)
        }
        result = result.sorted {
            $0.id < $1.id
        }
        return result
    }
    
    
    
    func add(_ pokemon: PKMPagedObject<PKMPokemon>) async {
        guard let pokemonResults = pokemon.results as? [PKMNamedAPIResource] else {
            return
        }
        for result in pokemonResults {
            let pokemon = Pokemon()
            do {
                let addPokemon = try await PokemonAPI().pokemonService.fetchPokemon(result.name!)
                guard let realm = Pokemon.realm else {
                    return
                }
                pokemon.name = addPokemon.name ?? ""
                pokemon.id = addPokemon.id ?? 0
                pokemon.sprites = PokemonSprites()
                pokemon.sprites?.add(addPokemon)
                
                realm.beginWrite()
                realm.add(pokemon)
                try realm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

