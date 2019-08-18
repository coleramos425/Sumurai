//
//  LoadingScreenViewController.swift
//  Sumurai
//
//  Created by Jachimike Onuoha on 8/8/19.
//  Copyright © 2019 CodeBusters IC. All rights reserved.
//

import Foundation
import UIKit
import Lottie
class LoadingScreenViewController: UIViewController{
    
    
    @IBOutlet weak var animationView: AnimationView!
    var animation = AnimationView(name: "6936-class-ninjas-floating-ninja")
    @IBOutlet weak var loadingMessage: UILabel!
    
    var delay = 16
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(delay), target: self, selector: #selector(changeScreen), userInfo: nil, repeats: false)
    }
    
    func startAnimation(){
        animation.frame = view.bounds
        animation.contentMode = .scaleAspectFit
        self.view.addSubview(animation)
        animation.play()
        animation.loopMode = .loop
        loadingMessage.text = "Converting your document..."
    }
    
    @objc func changeScreen(){
        // Switches to home page storyboard and resets the login storyboard
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as? ViewController
        {
            present(vc, animated: true, completion: nil)
        }
}
}
