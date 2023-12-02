//
//  Extensions.swift
//  CloneNetflixFreeCodeCamp
//
//  Created by Irvan P. Saragi on 02/12/23.
//

import Foundation

extension String{
    func capitalizeFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
