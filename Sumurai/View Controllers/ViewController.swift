//
//  ViewController.swift
//  Sumurai
//
//  Created by Jachimike Onuoha on 7/16/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MobileCoreServices

//protocol DataDelegate {
//    func sendString(_ string:String)->String
//}


class ViewController: UIViewController{
    
    var rtfName: String = ""
    var jachi: [String] = []
    var boldText: [String] = []
    var centerText: [String] = []
    var sections: [String] = []
    var Headings: [String] = []
    var word:String? = nil
    var text:String? = nil
    var statement: [String] = []
    

    
    @IBOutlet weak var newSumBtn: UIButton!
    
    
    let group = DispatchGroup()
    var documnetPickerVC: UIDocumentPickerViewController
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        documnetPickerVC = UIDocumentPickerViewController(documentTypes: ["public.text", "public.jpeg", "public.data", "public.html"], in: UIDocumentPickerMode.import)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //documnetPickerVC.delegate = self
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        documnetPickerVC = UIDocumentPickerViewController(documentTypes: ["public.text", "public.jpeg", "public.data", "public.html"], in: UIDocumentPickerMode.import)
        super.init(coder: aDecoder)
        documnetPickerVC.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ViewDidSubviews: \(self.statement)")
        
//        let file = "Start.txt"
//        let content = "Initialize app save space"
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let fileURL = dir.appendingPathComponent(file)
//        do{
//            try content.write(to: fileURL, atomically: false, encoding: .utf8)
//        }
//        catch{
//            print("NAAANI")
//        }
    }
    
    
    
    
    
    
    
    //USER DEFAULT STUFF----------------------------------------------------------------------------------
    
    
    
    
    func saveFileDefaults(_ sender: Any) {
        
        //All inputs are coming from user input or summary API
        
        let file = File(title: "MyFile", author: "My Author", type: "my Type", level: 2)
        
        let defaults = UserDefaults.standard
        
        
        do{
            let fileData = try NSKeyedArchiver.archivedData(withRootObject: file, requiringSecureCoding: true)
            defaults.set(fileData, forKey: "file")
        }
            
        catch{
            print("Why are you running")
        }
    }
    
    //IBAction
    
    func loadingFileDefaults(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        guard let fileData = defaults.object(forKey: "file") as? Data else {
            return
        }
        do {
            guard let file = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData) as? File else {
                return
            }
        } catch {
            print("Couldn't read file.")
        }
    }
    
    
    
    
     //JACHI STUFF--------------------------------------------------------------------------------------
    

    func convertToRTF(_ myFile: String, completionHandler: @escaping(Bool?, Error?)->Void){
        group.enter()
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadingScreen") as? LoadingScreenViewController
        {
            self.present(vc, animated: true, completion: nil)
        }
        
        var beenUploaded = false
        
        let pathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = pathURL.appendingPathComponent(myFile)
        let endpoint = "https://api.zamzar.com/v1/jobs"
        let api_key = "772f5625451d98c47445a5aad794f30982e0d433"
        let password = ""
        let target_format = "rtf"
        let loginString = "\(api_key):\(password)"
        
        // HTTP Basic Auth Username and Password login credentials
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        // Headers
        let header: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64LoginString)"
        ]
        
        //Upload file to convert to be converted
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append("\(target_format)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "target_format")
                multipartFormData.append(fileURL, withName: "source_file")
        },
            to: "\(endpoint)", method: .post, headers: header, encodingCompletion: { encodingResult in switch encodingResult {
            case .success(let upload, _, _):
                upload.responseData { response in
                    self.group.leave()
                    
                    //self.delegate?.showSuccessAlert()
                    print(response.request!)  // original URL request
                    print(response.response!) // URL response
                    print(response.data!)     // server data
                    print(response.result)   // result of response serialization
                    //                        self.showSuccesAlert()
                    beenUploaded = true
                    completionHandler(beenUploaded, nil)
                    
                }
                upload.responseJSON { response in
                }
            case .failure(let encodingError):
                print(encodingError)
                }
        })
        return
    }
    
    
    
    
    // GET THE ID FOR THE MOST RECENT FILE UPLOADED
    func getFileID(completionHandler: @escaping (AnyObject?, Error?)-> Void){
        sleep(4)
        // Get file id
        let api_key = "772f5625451d98c47445a5aad794f30982e0d433"
        let password = ""
        let endpoint2 = "https://api.zamzar.com/v1/files"
        let loginString = "\(api_key):\(password)"
        
        // HTTP Basic Auth Username and Password login credentials
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        let header2: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64LoginString)"
        ]
        
        group.enter()
        Alamofire.request(endpoint2, method: .get, headers: header2) .responseData{ response in
            do {
                let Anna = try JSONSerialization.jsonObject(with: response.data!, options: [])
                guard let json2 = Anna as? Dictionary<String,AnyObject> else{
                    return
                }
                print("This is JSON \(json2)")
                let array = json2["data"]! as? NSArray
                print("This is \(array)")
                let answer = array![0] as? NSDictionary
                print(answer)
                print(answer!["id"]!)
                let finalResult = answer!["id"]! // Needs fixing
                print(finalResult)
                completionHandler(finalResult as AnyObject, nil)
                //  print(type(of: answer))
                self.group.leave()                           //sleep(4)
                
            } catch {
                print("error")
            }
        }
        
    }
    
    
    //Downloading the .rtf
    func downloadRTF(_ fileID: AnyObject, _ myFile: String){
        // Download the converted file
        let newID = String(describing: fileID)
        print(newID)
        let api_key = "772f5625451d98c47445a5aad794f30982e0d433"
        let password = ""
        let endpoint3 = "https://api.zamzar.com/v1/files/\(newID)/content" //edit to take value of file id
        let fileArr =  myFile.components(separatedBy: ".")
        var newFile = fileArr[0] + ".rtf" // provided right appending for file
        let loginString = "\(api_key):\(password)"
        
        // HTTP Basic Auth Username and Password login credentials
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        let header2: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64LoginString)"
        ]
        // Headers
        let header3: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "Authorization": "Basic \(base64LoginString)",
            "Accept": "application/rtf"
        ]
        let parameters = ["stream":true]
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let directoryURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let folderPath: URL = directoryURL.appendingPathComponent(newFile, isDirectory: false) //edit to take the name of the file
            let destinationURLForFile = folderPath
            return(destinationURLForFile, [.init()])
        }
        
        group.enter()
        Alamofire.download(endpoint3, method:.get, parameters: parameters, headers: header3, to: destination).downloadProgress(closure: {(prog) in }).responseData{
            response in
            if let statusCode = response.response?.statusCode, statusCode == 200 {
                print(response.result.value)
                self.group.leave()
                //                self.jachi = self.getHeadings(myFile)
                //                print("Here are the headings \(self.jachi)")
                
                //Send newFile name
                UserDefaults.standard.set(newFile, forKey: "convertedFile")
            }
            
        }
        
    }
    
    // Send Filename
    
    
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
                    if (font.pointSize > 13) && (font.fontDescriptor.symbolicTraits.contains(.traitBold)) {
                        // it's bold, so append it to the array named boldText
                        word = attributedStringWithRtf.attributedSubstring(from: range).string
                        Headings.append(word ?? "No bold Text")
                    }
                }
                // Displays the text on the TextView
            }// end of bold check
            
        }
        catch let error {
            print("Got an Heading error \(error)")
        }
        
        return Headings //returns the large text
    }
    
    
    // Jachi worte this comment
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
                if let font = value as? UIFont {
                    if !((font.pointSize > 13) && (font.fontDescriptor.symbolicTraits.contains(.traitBold))) {
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
    func getSummary(_ text:String, completion: @escaping (String?) -> Void){
        var result:String = ""
        var request = URLRequest(url: URL(string: "https://api.meaningcloud.com/summarization-1.0")!)
        request.httpMethod = "POST"
        request.httpBody = "key=b001e406c6b0310910ff2ddaf4d63b3a&txt=\(text)&sentences=5".data(using: .utf8)  //try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            //print(response!)
            do{
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                //print("============================================================ \n")
                // print("             MEANINGCLOUD RESPONSE STARTS HERE               \n")
                result = json["summary"] as? String ?? "Something didn't work"
                completion(result)
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    
    // OBSERVER function for viewUpdate
    func observer(_ para:String){
        self.statement.append(para)
        DispatchQueue.main.async {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        
    }
    
    //Buttons
    @IBAction func Upload1Touch(_ sender: UIButton) {
        self.present(documnetPickerVC, animated: true, completion: nil)
        
    }
}



/// Document Picker
extension ViewController : UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])  {
        for document in urls {
            self.rtfName = document.lastPathComponent
            //save document.lastPathComponent (without extension) to userDefault
            convertToRTF(rtfName) {beenUploaded, error in
                self.getFileID(){ response, error in
                    self.downloadRTF(response!, self.rtfName)
                }
            }
            //get headers of the document and save them to an array
            //send headers to the UI
            //get sections of document and save them to an array
            //send sections to the summarizer
            //send summarized sections to the UI
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("LARISSA cancled LARISSA")
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
}
