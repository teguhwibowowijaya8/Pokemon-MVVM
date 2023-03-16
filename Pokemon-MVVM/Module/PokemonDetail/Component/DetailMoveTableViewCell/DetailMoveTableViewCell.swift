//
//  DetailMoveTableViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class DetailMoveTableViewCell: UITableViewCell {
    static let identifier = "DetailMoveTableViewCell"
    
    @IBOutlet weak var pokemonMoveTextView: UITextView!
    @IBOutlet weak var pokemonMoveEffectivenessLabel: UILabel!
    @IBOutlet weak var pokemonMoveSeparatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
