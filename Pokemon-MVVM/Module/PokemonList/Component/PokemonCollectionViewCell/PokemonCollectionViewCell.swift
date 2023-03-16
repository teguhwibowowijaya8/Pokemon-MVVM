//
//  PokemonCollectionViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

protocol PokemonCollectionCellDelegate {
    func getImageURL(
        of detailUrl: String,
        onCompletion: @escaping (String?) -> Void
    )
}

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
    
    private let defaultImage: UIImage? = UIImage(systemName: "star")
    private var getPokemonListImageService: GetPokemonListImageService?
    
    var delegate: PokemonCollectionCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(with pokemon: PokemonModel) {
        setupImages(pokemonUrlString: pokemon.url)
        pokemonNameLabel.text = pokemon.name
    }
    
    func setupImages(pokemonUrlString: String) {
        delegate?.getImageURL(of: pokemonUrlString, onCompletion: { pokemonImageUrl in
            self.pokemonImageView.loadImage(from: pokemonImageUrl, withPlaceholder: self.defaultImage)
        })
    }
    
}
