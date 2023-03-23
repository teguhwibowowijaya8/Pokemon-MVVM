//
//  ErrorCollectionViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 21/03/23.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {
    static let identifier = "ErrorCollectionViewCell"
    var delegate: ErrorViewProtocol?
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(errorMessage: String) {
        
        errorView.delegate = self
        errorView.setupErrorView()
        errorView.setErrorMessage(with: errorMessage)
        
        self.contentView.addSubview(errorView)
        setupComponentsConstraints()
        
    }
    
    private func setupComponentsConstraints() {

        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            errorView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            errorView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor),
        ])
        
    }
}

extension ErrorCollectionViewCell: ErrorViewProtocol {
    func onReloadButtonSelected() {
        delegate?.onReloadButtonSelected()
    }
}
