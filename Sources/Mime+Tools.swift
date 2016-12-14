//
//  Mime+Tools.swift
//  MimeLibGenerator
//
//  Created by Ondrej Rafaj on 14/12/2016.
//  Copyright © 2016 manGoweb UK Ltd. All rights reserved.
//

import Foundation


public extension Mime {
    
    public static func string(forUrl url: URL) -> String? {
        let ext: String = url.pathExtension
        guard ext != "" else {
            return nil
        }
        return Mime.get(fileExtension: ext)?.rawValue
    }
    
    public static func string(forPath path: String) -> String? {
        let url: URL = URL(fileURLWithPath: path)
        return self.string(forUrl: url)
    }
    
}
