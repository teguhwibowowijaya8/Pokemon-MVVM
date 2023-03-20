//
//  PokemonCollectionViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonCollectionViewCell"
    
    @IBOutlet weak var pokemonCardView: UIView! {
        didSet {
            pokemonCardView.layer.cornerRadius = 10
            pokemonCardView.layer.borderColor = UIColor.black.cgColor
            pokemonCardView.layer.borderWidth = 1
        }
    }
    
    @IBOutlet weak var pokemonImageView: UIImageView! {
        didSet {
            pokemonImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var pokemonImageSeparatorView: UIView! {
        didSet {
            pokemonImageSeparatorView.backgroundColor = .black
        }
    }
    
    @IBOutlet weak var pokemonNameLabel: UILabel! {
        didSet {
            pokemonNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
            pokemonNameLabel.numberOfLines = 2
            pokemonNameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    var imageUrlString = ""
    private let defaultImage: UIImage? = UIImage(named: "pokemon")
    private var getPokemonListImageService: GetPokemonListImageService?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        pokemonImageView.image = defaultImage
    }
    
    func setupCell(with pokemon: PokemonModel) {
        if let pokemonImage = pokemon.image?.sprites.imageUrlString, imageUrlString != pokemonImage {
            imageUrlString = pokemonImage
            pokemonImageView.image = defaultImage
            self.pokemonImageView.loadImage(from: pokemon.image?.sprites.imageUrlString, withPlaceholder: self.defaultImage)
        }
        
        pokemonNameLabel.text = pokemon.name.capitalized(with: .current)
    }
    
}
