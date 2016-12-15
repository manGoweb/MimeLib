//
//  Example.swift
//  MimeLibGenerator
//
//  Created by Ondrej Rafaj on 14/12/2016.
//  Copyright © 2016 manGoweb UK Ltd. All rights reserved.
//

import Foundation


final class Example {
    
    static func run() {
        print("Couple of examples:")
        
        print(Mime.fileExtension(forMime: "text/plain")!)                   // Prints: txt
        print(Mime.fileExtension(forMime: "application/octet-stream")!)     // Prints: bin
        print(Mime.get(fileExtension: "psd")!.rawValue)                     // Prints: image/vnd.adobe.photoshop
        print(Mime.get(fileExtension: "ogg") ?? "nil result")               // Prints: nil result
        print(Mime.string(forPath: "/home/file.pdf")!)                      // Prints: application/pdf
        
        print("\n\n")
    }
}
