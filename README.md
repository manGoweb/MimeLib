# MimeLib
Swift 3.0 mime types library
> MimeLib is a library that makes it easy to get the right mime type or file extension for your files written in swift

### Generating source
If you want to generate files straight from the Xcode project, you have two options, you can either:
* Pass ```"$(SRCROOT)/../Sources/"``` as a build argument, this will tell the app the location of the source files
* Leave the path empty and the content will be printed into the console

### Features
- [x] Convert extension to relevant mime type
- [x] Convert mime type to relevant path extension

## Installation

### Swift Package Manager

```swift
.Package(url: "https://github.com/manGoweb/MimeLib.git", majorVersion: 1)
```

## Usage

Couple of examples:
```swift
Mime.fileExtension(forMime: "text/plain")                  // Prints: txt
Mime.fileExtension(forMime: "application/octet-stream")    // Prints: bin
Mime.get(fileExtension: "psd")!.rawValue                   // Prints: image/vnd.adobe.photoshop
Mime.get(fileExtension: "ogg") ?? "nil result"             // Prints: nil result
Mime.string(forPath: "/home/file.pdf")                     // Prints: application/pdf
```

## Info

:gift_heart: Contributing
------------
Please create an issue with a description of your problem or open a pull request with a fix.

:v: License
-------
MIT

:poop: Author
------
Ondrej Rafaj - http://www.mangoweb.cz/en, [@rafiki270](http://twitter.com/rafiki270)
