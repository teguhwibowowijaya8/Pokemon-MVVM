//
//  UIImageView+loadImageURL.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?, withPlaceholder imagePlaceholder: UIImage?, onCompletion: ((UIImage?) -> Void)? = nil) {
        guard let urlString = urlString,
                let url = URL(string: urlString)
        else { return self.image = imagePlaceholder }
        
        let getImageService = GetImageService()
        getImageService.getImage(from: url) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let responseImage):
                    UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve) {
                        self.image = responseImage
                        onCompletion?(responseImage)
                        return
                    }
                case .failure(_):
                    self.image = imagePlaceholder
                    onCompletion?(nil)
                    return
                }
            }
        }
    }
    
    
}
