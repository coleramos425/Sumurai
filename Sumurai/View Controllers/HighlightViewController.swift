//
//  HighlightViewController.swift
//  Sumurai
//
//  Created by Cole Ramos on 7/25/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import UIKit
import Cards
import Foundation
import Lottie
class HighlightViewController: UIViewController{
    
    var check = false
    var docName: String = ""
    var boldText: [String] = []
    var centerText: [String] = []
    var sections: [String] = []
    var Headings: [String] = []
    var summaries: [String] = []
    var word:String? = nil
    var text:String? = nil
    var statement: [String] = []



    //@IBOutlet weak var first: CardHighlight!
    
    @IBOutlet weak var indicator: UILabel!
    
    @IBOutlet weak var highlightLit: CardHighlight!
    
    
    @IBOutlet var highlightSpanish: CardHighlight!
    
    
    @IBOutlet weak var highlightScience: CardHighlight!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightLit.delegate = self
        
        highlightLit.hasParallax = true
        highlightLit.title = "Attitudes towards Literature"              //Article Title
        highlightLit.itemTitle = "Daniela Presca"                        //Author
        highlightLit.itemSubtitle = "8/9/2019"                             //Date Created
        highlightLit.backgroundImage = UIImage(named: "theBook.jpg")    //Background color
        highlightLit.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let cardContent = storyboard?.instantiateViewController(withIdentifier: "CardContent")
        highlightLit.shouldPresent(cardContent, from: self, fullscreen: true)
        
        highlightSpanish.delegate = self
        highlightSpanish.hasParallax = true
        highlightSpanish.title = "Computer Science"              //Article Title
        highlightSpanish.itemTitle = ""                        //Author
        highlightSpanish.itemSubtitle = "8/9/2019"                             //Date Created
        highlightSpanish.backgroundImage = UIImage(named: "comp_sci.jpeg")    //Background color
        highlightSpanish.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let cardContent2 = storyboard?.instantiateViewController(withIdentifier: "CardContent")
        highlightSpanish.shouldPresent(cardContent2, from: self, fullscreen: true)
        highlightScience.delegate = self
        highlightScience.hasParallax = true
        highlightScience.title = "Microsoft: The Tech Titan"              //Article Title
        highlightScience.itemTitle = ""                        //Author
        highlightScience.itemSubtitle = "8/9/2019"                             //Date Created
        highlightScience.backgroundImage = UIImage(named: "microsoft filler.jpg")    //Background color
        highlightScience.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let cardContent3 = storyboard?.instantiateViewController(withIdentifier: "CardContent")
        highlightScience.shouldPresent(cardContent3, from: self, fullscreen: true)

    
    }
    
    func random(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
}


extension HighlightViewController: CardDelegate {
    
    func updateText(){
        indicator.text = "Loading Sumurai"
    }
    
    // RTF WebCrawler
    func getHeadings(_ document:String)->Array<String>{
        let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = pathURL.appendingPathComponent(document)
        do {
            // Finds all the sentences that are bold
            let attributedStringWithRtf: NSMutableAttributedString =
                try NSMutableAttributedString(url:  fileURL , options: [NSMutableAttributedString.DocumentReadingOptionKey.documentType:
                    NSMutableAttributedString.DocumentType.rtf], documentAttributes: nil)
            attributedStringWithRtf.enumerateAttribute(NSMutableAttributedString.Key.font, in: NSRange(0..<attributedStringWithRtf.length)) {
                value, range, stop in
                if let font = value as? UIFont {
                    // make sure this font is actually bold
                    if (font.fontDescriptor.symbolicTraits.contains(.traitBold)) {
                        // it's bold, so append it to the array named boldText
                        word = attributedStringWithRtf.attributedSubstring(from: range).string
                       Headings.append(word ?? "No bold Text")
                    }
                }
                // Displays the text on the TextView
            }// end of bold check
            
//            attributedStringWithRtf.enumerateAttribute(NSMutableAttributedString.Key.paragraphStyle, in: NSRange(0..<attributedStringWithRtf.length)) {
//                value, range, stop in
//                if let align = value as? NSParagraphStyle {
//                    // make sure this font is actually bold
//                    if align.alignment == .center {
//                        // it's bold, so append it to the array named boldText
//                        text = attributedStringWithRtf.attributedSubstring(from: range).string
//                        centerText.append(word ?? "center Text")
//                    }
//                }
//                // Displays the text on the TextView
//            }// end of center check
            
        }
        catch let error {
            print("Got an Heading error \(error)")
        }
        
        return Headings //returns the large text
    }
    
    
    //Find all the sections in the document
    func getSections(_ document:String)->Array<String>{
        let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = pathURL.appendingPathComponent(document)
        do{
            let attributedStringWithRtf: NSMutableAttributedString =
                try NSMutableAttributedString(url: fileURL, options: [NSMutableAttributedString.DocumentReadingOptionKey.documentType:
                    NSMutableAttributedString.DocumentType.rtf], documentAttributes: nil)
            attributedStringWithRtf.enumerateAttribute(NSMutableAttributedString.Key.font, in: NSRange(0..<attributedStringWithRtf.length)) {
                value, range, stop in
                if let font = value as? UIFont{
                    if !(font.fontDescriptor.symbolicTraits.contains(.traitBold)){
                        word = attributedStringWithRtf.attributedSubstring(from: range).string
                        sections.append(word ?? "No bold Text")
                    }
                }
                // Displays the text on the TextView
            }
        }
        catch let error {
            print("Got a section error \(error)")
        }
        
        return sections
    }
    
    
    // Summarizer(MeaningCloud) API Call
    func getSummary(_ text:String, completionHandler: @escaping(String?, Error?)->Void){
        var result:String = ""
        var request = URLRequest(url: URL(string: "https://api.meaningcloud.com/summarization-1.0")!)
        request.httpMethod = "POST"
        request.httpBody = "key=b001e406c6b0310910ff2ddaf4d63b3a&txt=\(text)&sentences=1".data(using: .utf8)  //try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print("This is the response: \(response!)")
            do{
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                //print("============================================================ \n")
                // print("             MEANINGCLOUD RESPONSE STARTS HERE               \n")
               // print("This is the \(json)")
                result = json["summary"] as? String ?? "Something didn't work"
                completionHandler(result, nil)
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    
    func doSummary(_ array:Array<String>, completionHandler: @escaping(Bool?, Error?)->Void){
        var hasSummarised = false
        for i in array{
            if (i.count > 2) && (i != "\n" || i != "\t"){
                print(i)
                sleep(1)
            self.getSummary(i){ result, error in
                self.statement.append(result!)
                print(result!)
            }
            }
        }
        hasSummarised = true
        completionHandler(hasSummarised, nil)
    }
    
    
    func cardDidTapInside(card: Card) {
        updateText()
        self.check = true
        var checker = false
        let docName = UserDefaults.standard.string(forKey: "convertedFile")
        Headings = getHeadings(docName!)
        print(Headings)
//        UserDefaults.standard.set(Headings, forKey: "SectionHeaders")
        sections = getSections(docName!)
        UserDefaults.standard.set(self.sections, forKey: "mySections")
//        print("Here is the section \(sections)")
//        print("Here is the section \(Headings)")
        doSummary(sections){ hasSummarised, error in
            if hasSummarised == true{
                UserDefaults.standard.set(self.Headings, forKey: "SectionHeaders")
                UserDefaults.standard.set(self.statement, forKey: "SummarisedSections")
                print(self.statement)
              self.indicator.text = "Previous Sumuraies"
            }
        }
        
        

//        print("This the headings \(Headings)")
//        print("This the sections \(sections)")
        //if card == first {
        //card.shadowColor = colors[random(min: 0, max: colors.count-1)]
        //(card as! CardHighlight).title = "everyday \nI'm \nshufflin'"
        //} else {
        print("Hey, I'm the second one :)")
        //}
    }
    
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        
        card.buttonText = nil
        
        //if card == self.second {
        card.open()
        //}
    }
    
}
