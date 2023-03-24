//
//  DetailMoveTableViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

class DetailMoveTableViewCell: UITableViewCell {
    static let identifier = "DetailMoveTableViewCell"
    
    @IBOutlet weak var moveDetailContainerView: UIView!
    @IBOutlet weak var moveNameLabel: UILabel!
    
    @IBOutlet weak var moveDescriptionTextView: UITextView! {
        didSet {
            moveDescriptionTextView.textContainerInset = .zero
            moveDescriptionTextView.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: -4)
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
    
    @IBOutlet weak var moveDescriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveDescriptionTopAnchorConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveDescriptionBottomAnchorConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(
        moveName: String,
        moveDetail: MoveDetailModel?,
        hideMoveDescription: Bool = true
    ) {
        var moveDescription: NSAttributedString? = nil
        var moveEffectiveness: String = "0"
        
        if let moveDetail = moveDetail {
            moveEffectiveness = setupMoveEffectiveness(with: moveDetail.accuracy, power: moveDetail.power, pp: moveDetail.pp)
            
            if let effect = moveDetail.effectString {
                moveDescription = NSAttributedString(
                    string: effect,
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 14)
                    ])
            }
        }
        
        if moveDescription == nil || hideMoveDescription {
            moveDescriptionTextView.text = ""
            moveDescriptionTextView.isHidden = true
            hideMoveDescriptionConstraints()
        }
        else {
            moveDescriptionTextView.isHidden = false
            self.moveDescriptionTextView.attributedText = moveDescription
            showMoveDescriptionConstraints()
        }
        
        self.moveNameLabel.attributedText = NSAttributedString(
            string: moveName.capitalized(with: .current),
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 18)
            ]
        )
        
        self.pokemonMoveEffectivenessLabel.text = moveEffectiveness
    }
    
    func hideMoveDescriptionConstraints() {
        moveDescriptionHeightConstraint.priority = .defaultHigh
        moveDescriptionTopAnchorConstraint.constant = -7
        moveDescriptionBottomAnchorConstraint.constant = 0
    }
    
    func showMoveDescriptionConstraints() {
        moveDescriptionHeightConstraint.priority = .defaultLow
        moveDescriptionTopAnchorConstraint.constant = 8
        moveDescriptionBottomAnchorConstraint.constant = 8
    }
    
    func setupMoveEffectiveness(with accuracy: Int?, power: Int?, pp: Int?) -> String {
        let movePp = (pp != nil) ? "\(pp!) pp" : "0"
        let movePower = (power != nil) ? "\(power!) power" : movePp
        let moveEffectiveness = (accuracy != nil) ? "\(accuracy!) accuracy" : movePower
        
        return moveEffectiveness.capitalized(with: .current)
    }
    
}
