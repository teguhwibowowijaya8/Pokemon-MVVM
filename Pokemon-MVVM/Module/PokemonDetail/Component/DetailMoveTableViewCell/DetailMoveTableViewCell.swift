//
//  DetailMoveTableViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class DetailMoveTableViewCell: UITableViewCell {
    static let identifier = "DetailMoveTableViewCell"
    
    @IBOutlet weak var pokemonMoveTextView: UITextView! {
        didSet {
            pokemonMoveTextView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            pokemonMoveTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    @IBOutlet weak var pokemonMoveEffectivenessLabel: UILabel!
    @IBOutlet weak var pokemonMoveSeparatorView: UIView! {
        didSet{
            pokemonMoveSeparatorView.backgroundColor = .black
        }
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(moveName: String, moveEffect: String?, moveAccuracy: Int?) {
        let move: String
        let accuracy: Int
        if let moveEffect = moveEffect {
            move = "\(moveName)\n\n\(moveEffect)"
            accuracy = moveAccuracy ?? 0
        } else {
            move = moveName
            accuracy = 0
        }
        self.pokemonMoveTextView.text = move
        self.pokemonMoveEffectivenessLabel.text = "\(accuracy)"
    }
    
}
