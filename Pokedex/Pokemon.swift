//
//  Pokemon.swift
//  Pokedex
//
//  Created by Guner Babursah on 02/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _baseAttack: String!
    fileprivate var _nextEvoTxt: String!
    fileprivate var _nextEvoName: String!
    fileprivate var _nextEvoId: String!
    fileprivate var _nextEvoLevel: String!
    fileprivate var _pokemonURL: String!
    
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let attack = dict["attack"] as? Int {
                    self._baseAttack = "\(attack)"
                }
               
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
//                print(self._defense)
//                print(self._baseAttack)
//                print(self._height)
//                print(self._weight)
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }else{
                        self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let urlOrigin = "\(URL_BASE)\(url)"
                        Alamofire.request(urlOrigin).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let descrip = descDict["description"] as? String {
                                    let descript = descrip.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    self._description = descript
                                }
                            }
                            completed()
                        })
                    }
                }else{
                    self._description = ""
                }
                
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolution.count > 0 {
                    if let nextEvolution = evolution[0]["to"] as? String {
                        if nextEvolution.range(of: "mega") == nil {
                            self._nextEvoName = nextEvolution
                            
                            if let uri = evolution[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvolutionId = newStr.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextEvolutionId
                                
                                if let lvlExist = evolution[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvoLevel = "\(lvl)"
                                }
                                }else{
                                    self._nextEvoLevel = ""
                                }
                            
                            }
                        }
                    }
//                    print(self._nextEvoLevel)
//                    print(self._nextEvoId)
//                    print(self._nextEvoName)
                }

            }
            
            completed()
        }
        
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    var nextEvoName: String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    var baseAtttack: String {
        if _baseAttack == nil{
            _baseAttack = ""
        }
        return _baseAttack
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var type: String{
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var name: String {
        
        return _name
    }
    var pokedexId: Int {
        
        return _pokedexId
    }
}










