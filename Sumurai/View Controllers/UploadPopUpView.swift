//
//  UploadPopUpView.swift
//  Sumurai
//
//  Created by Cole Ramos on 8/4/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit

class UploadPopUpViewController: UIViewController, UIDocumentPickerDelegate{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var Upload1Button: UIButton!
    @IBOutlet weak var Upload2Button: UIButton!
    @IBOutlet weak var Upload3Button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func Upload2Touch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func Upload3Touch(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
