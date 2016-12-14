//
//  Updater.swift
//  MimeLibGenerator
//
//  Created by Ondrej Rafaj on 14/12/2016.
//  Copyright © 2016 manGoweb UK Ltd. All rights reserved.
//

import Foundation


final class Updater {
    
    static func write(data: String, toFile file: URL) {
        print("Looking for \(file.path)")
        guard FileManager.default.fileExists(atPath: file.path) else {
            print("File not found")
            return
        }
        var fileContent: String = try! String.init(contentsOfFile: file.path, encoding: String.Encoding.utf8)
        
        if let dotRange = fileContent.range(of: "!") {
            fileContent.removeSubrange(dotRange.lowerBound..<fileContent.endIndex)
        }
        
        fileContent += "\n\n"
        fileContent += data
        
        try! fileContent.write(to: file, atomically: true, encoding: String.Encoding.utf8)
    }
    
}
