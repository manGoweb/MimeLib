//
//  main.swift
//  MimeLibGenerator
//
//  Created by Ondrej Rafaj on 14/12/2016.
//  Copyright © 2016 manGoweb UK Ltd. All rights reserved.
//

import Foundation


// MARK: Start program

print("MimeLibGenerator starting ...\n")

// MARK: Getting arguments

var path: String = "./"

var c = 0;
for arg: String in CommandLine.arguments {
    if c == 1 && arg.characters.count > 0 {
        path = arg
        print("Export path set to: " + path)
    }
    c += 1
}

let url: URL = URL(string: "http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types")!
let dataString: String = try! String.init(contentsOf: url)
for line: String in dataString.lines {
    guard line.substring(to: 1) != "#" else {
        continue
    }
    print(line)
}




