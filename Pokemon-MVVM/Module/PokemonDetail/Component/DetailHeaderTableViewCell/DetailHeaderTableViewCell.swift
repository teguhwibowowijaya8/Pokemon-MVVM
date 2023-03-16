//
//  DetailHeaderTableViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    static let identifier = "DetailHeaderTableViewCell"
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonHealthLabel: UILabel!
    @IBOutlet weak var pokemonImageContainerView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView! {
        didSet {
            pokemonImageView.contentMode = .scaleAspectFill
        }
    }
    
    private let defaultImage = UIImage(systemName: "star")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(name: String, health: Int, imageUrlString: String?) {
        pokemonImageView.loadImage(from: imageUrlString, withPlaceholder: defaultImage)
        pokemonNameLabel.text = name
        pokemonHealthLabel.text = "\(health) HP"
    }
    
}
