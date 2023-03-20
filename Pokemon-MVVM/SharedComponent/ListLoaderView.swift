//
//  ListLoaderView.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 20/03/23.
//

import UIKit

class ListLoaderView: UIView {
    private lazy var activityLoader: UIActivityIndicatorView = {
       let activityLoader = UIActivityIndicatorView()
        activityLoader.translatesAutoresizingMaskIntoConstraints = false
        return activityLoader
    }()
    
    private lazy var loaderLabel: UILabel = {
        let loaderLabel = UILabel()
        loaderLabel.text = "Loading..."
        loaderLabel.textAlignment = .center
        loaderLabel.translatesAutoresizingMaskIntoConstraints = false
        return loaderLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupListLoaderView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupListLoaderView()
    }
    
    func setupListLoaderView() {
        self.addSubview(activityLoader)
        self.addSubview(loaderLabel)
        
        NSLayoutConstraint.activate([
            activityLoader.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            activityLoader.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 20),
            activityLoader.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -20),
            activityLoader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityLoader.widthAnchor.constraint(equalToConstant: 30),
            activityLoader.heightAnchor.constraint(equalTo: activityLoader.widthAnchor),
            
            
            loaderLabel.topAnchor.constraint(equalTo: activityLoader.bottomAnchor, constant: 5),
            loaderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            loaderLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            loaderLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func startAnimatingLoader() {
        self.activityLoader.startAnimating()
    }
}
