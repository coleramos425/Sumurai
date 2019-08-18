//
//  SumaraiLoadViewController.swift
//  Sumurai
//
//  Created by Jachimike Onuoha on 8/8/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit

class SumuraiLoad: UIViewController{
   
    var timer = Timer()
    override func viewDidLoad() {
        let holder = UserDefaults.standard.array(forKey: "mySections")
        let count = holder!.count
        let delay = count + 6
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(delay), target: self, selector: #selector(changeScreen), userInfo: nil, repeats: false)
    }
    
    @objc func changeScreen(){
        // Switches to home page storyboard and resets the login storyboard
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Listy") as? ListTableViewController
        {
            present(vc, animated: true, completion: nil)
        }
    }
    
}
