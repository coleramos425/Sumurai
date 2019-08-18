//
//  MainContentViewController.swift
//  Sumurai
//
//  Created by Cole Ramos on 7/31/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit

class MainContentViewController: UIViewController{
    
    @IBOutlet weak var bodyText: UILabel!
    
    //var contentText = UserDefaults.standard.string(forKey: "SummarisedSection")
    
    
    override func viewDidLoad() {
        print("Main Content Card has loaded!")
        bodyText.text? = UserDefaults.standard.string(forKey: "content")!
    
}
}
