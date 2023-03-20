//
//  LoaderCollectionViewCell.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 20/03/23.
//

import UIKit

class LoaderCollectionViewCell: UICollectionViewCell {
    static let identifier = "LoaderCollectionViewCell"
    
    private lazy var listLoaderView: ListLoaderView = {
        let listLoaderView = ListLoaderView()
        listLoaderView.translatesAutoresizingMaskIntoConstraints = false
        return listLoaderView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    func setupCell() {
        self.addSubview(listLoaderView)
        listLoaderView.startAnimatingLoader()
        NSLayoutConstraint.activate([
            listLoaderView.topAnchor.constraint(equalTo: self.topAnchor),
            listLoaderView.leftAnchor.constraint(equalTo: self.leftAnchor),
            listLoaderView.rightAnchor.constraint(equalTo: self.rightAnchor),
            listLoaderView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
