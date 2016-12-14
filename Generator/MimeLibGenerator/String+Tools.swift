//
//  String+Tools.swift
//  MimeLibGenerator
//
//  Created by Ondrej Rafaj on 14/12/2016.
//  Copyright © 2016 manGoweb UK Ltd. All rights reserved.
//

import Foundation


extension String {
    
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
    
    func substr(_ i: Int) -> String {
        guard i >= 0 && i < characters.count else { return "" }
        return String(self[self.index(self.startIndex, offsetBy: i)])
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}
