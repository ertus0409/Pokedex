//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Guner Babursah on 03/07/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import UIKit


class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var headlineLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var decription: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttacklbl: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        self.mainImage.image = img
        self.currentEvoImage.image = img
        self.pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetail {
            print("Compilation started")
            self.updateUI()
        }
    }
    
    
    func updateUI() {
        baseAttacklbl.text = pokemon.baseAtttack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        headlineLbl.text = pokemon.name.capitalized
        nameLbl.text = pokemon.type.capitalized
        decription.text = pokemon.description
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImage.isHidden = true
        }else{
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvoId)
            let str = "Next Evlution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            evoLbl.text = str
        }
//        evoLbl.text = "Next Evolution/ \(pokemon.nextEvo) \(pokemon.nextEvoLevel)"
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
}
