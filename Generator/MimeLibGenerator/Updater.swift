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
        else {
            fileContent = "//  Data has been extracted from an apache.org svn repository located on http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types/n/n"
            fileContent += "import Foundation\n\n\n"
        }
        
        fileContent += "!\n\n"
        fileContent += data
        
        try! fileContent.write(to: file, atomically: true, encoding: String.Encoding.utf8)
        print("File \(file.path) has been generated!")
    }
    
}
