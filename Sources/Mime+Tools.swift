//
//  Mime+Tools.swift
//  MimeLibGenerator
//
//  Created by Ondrej Rafaj on 14/12/2016.
//  Copyright © 2016 manGoweb UK Ltd. All rights reserved.
//

import Foundation


public extension Mime {
    
    public static func get(fileUrl url: URL) -> MimeType? {
        let ext: String = url.pathExtension
        guard ext != "" else {
            return nil
        }
        return Mime.get(fileExtension: ext)
    }
    
    public static func get(filePath path: String) -> MimeType? {
        let url: URL = URL(fileURLWithPath: path)
        return Mime.get(fileUrl: url)
    }
    
    public static func string(forUrl url: URL) -> String? {
        return Mime.get(fileUrl: url)?.rawValue
    }
    
    public static func string(forPath path: String) -> String? {
        let url: URL = URL(fileURLWithPath: path)
        return self.string(forUrl: url)
    }
    
}
