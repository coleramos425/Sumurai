//
//  File.swift
//  Sumurai
//
//  Created by Cole Ramos on 8/2/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit

class File: NSObject, NSCoding {
    
    var title: String
    var author: String
    var date: DateFormatter
    var cardType: String
    var level: Int// will change it int
    
    init(title: String, author: String, type: String, level: Int) {
        self.title = title
        self.author = author
        self.date = DateFormatter()
        self.cardType = type
        self.level = level
    }
    required init?(coder aDecoder: NSCoder) {
        
        title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        author = aDecoder.decodeObject(forKey: "author") as? String ?? ""
        date = aDecoder.decodeObject(forKey: "date") as? DateFormatter ?? DateFormatter()
        cardType = aDecoder.decodeObject(forKey: "cardType") as? String ?? ""
        level = aDecoder.decodeInteger(forKey: "level")
        super.init ()
        //            title: title,
        //            author: author,
        //            date: date,
        //            previewSummary: previewSummary,
        //            cardType: cardType,
        //            level: decoder.decodeInteger(forKey: "level")
        //        )
    }
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "title")
        coder.encode(self.author, forKey: "author")
        coder.encode(self.date, forKey: "date")
        coder.encode(self.cardType, forKey: "cardType")
        coder.encode(self.level, forKey: "level")
    }
    
    override var description: String {
        return "\(title), \(author), \(date), \(cardType), \(level)"
    }
    
}
