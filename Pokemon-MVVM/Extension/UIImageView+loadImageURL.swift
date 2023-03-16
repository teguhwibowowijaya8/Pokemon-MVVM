//
//  UIImageView+loadImageURL.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import UIKit

extension UIImageView {
    func loadImage(from urlString: String?, withPlaceholder image: UIImage?) {
        guard let urlString = urlString,
                let url = URL(string: urlString)
        else { return self.image = image }
        
        let getImageService = GetImageService()
        getImageService.getImage(from: url) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let responseImage):
                    return self.image = responseImage
                case .failure(_):
                    return self.image = image
                }
            }
        }
    }
    
    
}
