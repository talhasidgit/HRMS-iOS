//
//  IntroVC.swift
//  
//
//  Created by Ahmed on 30/12/2021.
//

import UIKit

class IntroVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    
}
