//
//  String+capitalizeFirstLetter.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import Foundation

extension String {
    mutating func capitalizeFirstLetter() {
        let newString = prefix(1).capitalized + dropFirst()
        self = newString
    }
}
