//
//  ArticleViewController.swift
//  Sumurai
//
//  Created by Cole Ramos on 7/30/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit
import Cards

class ArticleViewController: UIViewController{
    
    @IBOutlet weak var card: CardArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cardContent = storyboard?.instantiateViewController(withIdentifier: "CardContent")
        card.shouldPresent(cardContent, from: self)
        card.backgroundImage = UIImage(named: "theBook")
    }
}
