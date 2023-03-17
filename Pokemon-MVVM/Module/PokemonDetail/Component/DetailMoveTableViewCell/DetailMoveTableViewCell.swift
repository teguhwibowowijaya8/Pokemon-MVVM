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
    
    @IBOutlet weak var pokemonMoveEffectivenessLabel: UILabel!{
        didSet {
            pokemonMoveEffectivenessLabel.font = .boldSystemFont(ofSize: 18)
            pokemonMoveEffectivenessLabel.numberOfLines = 3
            pokemonMoveEffectivenessLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBOutlet weak var pokemonMoveSeparatorView: UIView! {
        didSet{
            pokemonMoveSeparatorView.backgroundColor = .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(moveName: String, moveDetail: MoveDetailModel?) {
        var move = setupMoveName(moveName)
        var moveEffectiveness: String = "0"
        
        if let moveDetail = moveDetail {
            moveEffectiveness = setupMoveEffectiveness(with: moveDetail.accuracy, power: moveDetail.power, pp: moveDetail.pp)
            
            if let effect = moveDetail.effectString {
                let moveEffect = NSAttributedString(
                    string: "\n\n\(effect)",
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 14)
                    ])
                move.append(moveEffect)
            }
        }
        
        self.pokemonMoveTextView.attributedText = move
        self.pokemonMoveEffectivenessLabel.text = moveEffectiveness
    }
    
    private func setupMoveName(_ name: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: name, attributes: [
            .font: UIFont.boldSystemFont(ofSize: 18)
        ])
        
        return attributedString
    }
    
    func setupMoveEffectiveness(with accuracy: Int?, power: Int?, pp: Int?) -> String {
        let movePp = (pp != nil) ? "\(pp!) pp" : "0"
        let movePower = (power != nil) ? "\(power!) power" : movePp
        let moveEffectiveness = (accuracy != nil) ? "\(accuracy!) accuracy" : movePower
        
        return moveEffectiveness
    }
    
}
