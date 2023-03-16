//
//  DetailMoveTableViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

protocol DetailMoveCellDelegate {
    func getMoveDetail(
        with urlString: String,
        onCompletion: @escaping (MoveDetailModel?) -> Void
    )
}

class DetailMoveTableViewCell: UITableViewCell {
    static let identifier = "DetailMoveTableViewCell"
    
    @IBOutlet weak var pokemonMoveTextView: UITextView!
    @IBOutlet weak var pokemonMoveEffectivenessLabel: UILabel!
    @IBOutlet weak var pokemonMoveSeparatorView: UIView!
    
    var delegate: DetailMoveCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(moveName: String, moveUrlString: String) {
        delegate?.getMoveDetail(with: moveUrlString, onCompletion: { moveDetail in
            let moveText: String
            let moveEffectiveness: Int
            
            if let moveDetail = moveDetail {
                moveText = "\(moveName)\n\n\(moveDetail.effectString)"
                moveEffectiveness = moveDetail.accuracy ?? 0
            } else {
                moveText = moveName
                moveEffectiveness = 0
            }
            
            DispatchQueue.main.async {
                self.pokemonMoveTextView.text = moveText
                self.pokemonMoveEffectivenessLabel.text = "\(moveEffectiveness)"
            }
        })
    }
    
}
