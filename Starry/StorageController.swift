//
//  StorageController.swift
//  Starry
//
//  Created by Chris Stroud on 10/9/15.
//  Copyright © 2015 HackNC. All rights reserved.
//

import Foundation
import UIKit

//
// Public definition of Hack
//
struct Hack {
    
    let title:String
    let rating:Int
    let uuid:String
    
    init(title:String, rating:Int) {
        self.title = title
        self.rating = rating
        self.uuid = NSUUID().UUIDString
    }
    
    var plistURL:NSURL {
        return NSFileManager.documentsURL.URLByAppendingPathComponent(self.uuid, isDirectory: false)
    }
}

//
// Keys used for serialization
//
private enum HackKey:String {
    case Title = "title"
    case Rating = "rating"
    case UUID = "uuid"
}

//
// Private Hack Extension
//
private extension Hack {
    
    init(withDictionary dict:[HackKey:AnyObject]) {
        self.title = dict[.Title] as! String
        self.rating = dict[.Rating] as! Int
        self.uuid = dict[.UUID] as! String
    }
    
    var dictionaryRepresentation:[String:AnyObject] {
        return [
            HackKey.Title.rawValue: self.title,
            HackKey.Rating.rawValue: self.rating,
            HackKey.UUID.rawValue:self.uuid,
        ]
    }
}

//
// Quick and dirty persistence class for storing/accessing/removing
// Hack instances from disk
//
class StorageController {
    
    class func allHacks() -> [Hack] {
        let fileManager = NSFileManager.defaultManager()
        var allHacks = [Hack]()
        guard let allContents = try? fileManager.contentsOfDirectoryAtURL(NSFileManager.documentsURL, includingPropertiesForKeys: nil, options: .SkipsHiddenFiles) else {
            return allHacks
        }
        for aURL in allContents {
            if let dict = NSDictionary(contentsOfURL: aURL) as? [String:AnyObject]{
                var hackDict = [HackKey:AnyObject]()
                for (key, value) in dict {
                    if let key = HackKey(rawValue: key) {
                        hackDict[key] = value
                    }
                }
                let currentHack = Hack(withDictionary: hackDict)
                allHacks.append(currentHack)
            }
        }
        return allHacks
    }
    
    class func persistHack(aHack:Hack) {
        let dict:NSDictionary = aHack.dictionaryRepresentation
        if dict.writeToURL(aHack.plistURL, atomically: true) == false {
            print("Failed to write dictionary to disk")
        }
    }
    
    class func removeHack(aHack:Hack) {
        let fileManager = NSFileManager.defaultManager()
        guard let _ = try? fileManager.removeItemAtURL(aHack.plistURL) else {
            print("Failed to delete \(aHack.plistURL)")
            return
        }
    }
}

