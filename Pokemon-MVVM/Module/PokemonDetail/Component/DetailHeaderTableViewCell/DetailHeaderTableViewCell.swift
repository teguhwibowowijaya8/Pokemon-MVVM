//
//  DetailHeaderTableViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    static let identifier = "DetailHeaderTableViewCell"
    
    @IBOutlet weak var pokemonNameLabel: UILabel! {
        didSet {
            pokemonNameLabel.font = .boldSystemFont(ofSize: 24)
        }
    }
    
    @IBOutlet weak var pokemonHealthLabel: UILabel!{
        didSet {
            pokemonHealthLabel.font = .boldSystemFont(ofSize: 20)
        }
    }
    
    @IBOutlet weak var pokemonImageContainerView: UIView! {
        didSet {
            pokemonImageContainerView.layer.borderColor = UIColor.black.cgColor
            pokemonImageContainerView.layer.borderWidth = 10
        }
    }
    
    @IBOutlet weak var pokemonImageView: UIImageView! {
        didSet {
            pokemonImageView.contentMode = .scaleAspectFit
        }
    }
    
    private let defaultImage = UIImage(systemName: "star")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String, health: Int, imageUrlString: String?) {
        pokemonImageView.loadImage(from: imageUrlString, withPlaceholder: defaultImage)
        pokemonNameLabel.text = name.capitalized(with: .current)
        pokemonHealthLabel.text = "\(health) HP"
    }
    
}
