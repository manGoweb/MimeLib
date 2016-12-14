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

var getExtensionOutput: String = "\tpublic static func get(fileExtension ext: String) -> MimeType? {\n"
getExtensionOutput += "\t\tswitch ext {\n"

var getMimeOutput: String = "\tpublic static func fileExtension(forMime mime: String) -> String? {\n"
getMimeOutput += "\t\tswitch mime {\n"

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
    
    getExtensionOutput += "\t\tcase \"\(ext)\":\n"
    getExtensionOutput += "\t\t\treturn .\(enumExt)\n"
    
    getMimeOutput += "\t\tcase \"\(mime)\":\n"
    getMimeOutput += "\t\t\treturn \"\(ext)\"\n"
}


enumOutput += "}"

getExtensionOutput += "\t\tdefault:\n"
getExtensionOutput += "\t\t\treturn nil\n"
getExtensionOutput += "\t\t}\n"
getExtensionOutput += "\t}\n\n"

getMimeOutput += "\t\tdefault:\n"
getMimeOutput += "\t\t\treturn nil\n"
getMimeOutput += "\t\t}\n"
getMimeOutput += "\t}\n\n"


var mimeOutput: String = "public class Mime {\n\n"
mimeOutput += getExtensionOutput
mimeOutput += getMimeOutput
mimeOutput += "}/n"

if path.characters.count == 0 {
    print(enumOutput)
    print("\n\n\n")
    print(mimeOutput)
}
else {
    var enumUrl: URL = URL(fileURLWithPath: path)
    enumUrl.appendPathComponent("MimeType.swift")
    Updater.write(data: enumOutput, toFile: enumUrl)
    
    var mimeUrl: URL = URL(fileURLWithPath: path)
    mimeUrl.appendPathComponent("Mime.swift")
    Updater.write(data: mimeOutput, toFile: mimeUrl)
}

print("\nThank you for using MimeLibGenerator!\n\nOndrej Rafaj & team manGoweb UK! (http://www.mangoweb.cz/en)\n\n\n")




