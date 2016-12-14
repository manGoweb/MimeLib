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

var path: String = ""

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

var enumOutput: String = "public enum MimeType: String {\n"

var switchOutput: String = "public class Mime {\n\n"
switchOutput += "\tpublic static func get(fileExtension ext: String) -> MimeType? {\n"
switchOutput += "\t\tswitch ext {\n"

var usedExtensions: [String] = []

for line: String in dataString.lines {
    guard line.substr(0) != "#" else {
        continue
    }
    
    let parts: [String] = line.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression).trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
    let ext: String = parts[1].lowercased()
    
    guard usedExtensions.index(of: ext) == nil else {
        continue
    }
    usedExtensions.append(ext)
    
    var enumExt = ext
    if Int(ext.substr(0)) != nil || ext == "class" {
        enumExt = "_" + ext
    }
    if enumExt.contains("-") {
        let arr = ext.components(separatedBy: "-")
        var x = 0
        for part: String in arr {
            if x == 0 {
                enumExt = part
            }
            else {
                enumExt += part.capitalizingFirstLetter()
            }
            x += 1
        }
    }
    
    let mime: String = parts[0].lowercased()
    
    enumOutput += "\tcase \(enumExt) = \"\(mime)\"\n"
    
    switchOutput += "\t\tcase \"\(ext)\":\n"
    switchOutput += "\t\t\treturn .\(enumExt)\n"
}


enumOutput += "}"

switchOutput += "\t\tdefault:\n"
switchOutput += "\t\t\treturn nil\n"
switchOutput += "\t\t}\n"
switchOutput += "\t}\n\n}\n"

if path.characters.count == 0 {
    print(enumOutput)
    print("\n\n\n")
    print(switchOutput)
}
else {
    var mimeUrl: URL = URL(fileURLWithPath: path)
    mimeUrl.appendPathComponent("Mime.swift")
    Updater.write(data: switchOutput, toFile: mimeUrl)
    
    var enumUrl: URL = URL(fileURLWithPath: path)
    enumUrl.appendPathComponent("MimeType.swift")
    Updater.write(data: enumOutput, toFile: enumUrl)
}




