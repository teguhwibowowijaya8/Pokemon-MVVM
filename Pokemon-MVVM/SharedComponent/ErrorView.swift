//
//  ErrorView.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 21/03/23.
//

import UIKit

protocol ErrorViewProtocol {
    func onReloadButtonSelected()
}

class ErrorView: UIView {
    
    var delegate: ErrorViewProtocol?
    
    private lazy var errorImageView: UIImageView = {
       let errorImageView = UIImageView()
        
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.image = UIImage(named: "error")
        
        return errorImageView
    }()
    
    private lazy var errorTextView: UITextView = {
        let errorTextView = UITextView()
        
        errorTextView.translatesAutoresizingMaskIntoConstraints = false
        errorTextView.isEditable = false
        errorTextView.isSelectable = false
        errorTextView.isScrollEnabled = false
        errorTextView.textAlignment = .center
        
        return errorTextView
    }()
    
    private lazy var errorReloadButton: UIButton = {
        let errorReloadButton = UIButton(type: .system)
        
        errorReloadButton.translatesAutoresizingMaskIntoConstraints = false
        errorReloadButton.setTitle("Reload Again", for: .normal)
        errorReloadButton.isUserInteractionEnabled = true
        
        return errorReloadButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupErrorView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupErrorView()
    }
    
    func setupErrorView() {
        errorReloadButton.addTarget(self, action: #selector(onReloadButtonSelected), for: .touchUpInside)
        
        self.addSubview(errorImageView)
        self.addSubview(errorTextView)
        self.addSubview(errorReloadButton)
        
        
        NSLayoutConstraint.activate([
            errorImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            errorImageView.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor, constant: 10),
            errorImageView.rightAnchor.constraint(lessThanOrEqualTo: self.rightAnchor, constant: -10),
            errorImageView.widthAnchor.constraint(equalToConstant: 100),
            errorImageView.heightAnchor.constraint(equalToConstant: 100),
            errorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            errorTextView.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 5),
            errorTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            errorTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            
            
            errorReloadButton.topAnchor.constraint(equalTo: errorTextView.bottomAnchor, constant: 5),
            errorReloadButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            errorReloadButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            errorReloadButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func onReloadButtonSelected(_ sender: UIButton) {
        print("Reload Selected")
        delegate?.onReloadButtonSelected()
    }
    
    func setErrorMessage(with message: String) {
        errorTextView.text = message
    }
}

