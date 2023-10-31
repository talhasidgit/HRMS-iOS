//
//  SettingsVC.swift
//  
//
//  Created by Ahmed on 12/01/2022.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet weak var versionLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLbl.text = "V \(appVersion ?? DefaultValue.string)"
    }

    // MARK: - PROFILE

    @IBAction func profileBtn(_ sender: Any) {
        performSegue(withIdentifier: "profileVC", sender: self)
    }

    // MARK: - ABOUT US

    @IBAction func aboutUsBtn(_ sender: Any) {
        performSegue(withIdentifier: "aboutusVC", sender: self)
    }

    // MARK: - CONTACT

    @IBAction func contact(_ sender: Any) {
        performSegue(withIdentifier: "contactusVC", sender: self)
    }

    // MARK: - FORGOT PASSWORD

    @IBAction func forgotPasswordBtn(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ForgotSBID") as! ForgotPasswordVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }

    // MARK: - LOGOUT

    @IBAction func logoutBtn(_ sender: Any) {
        let userInfo = AppUtility.sharedInstance.getUserData(forKey: LOGIN_INFO)

        if userInfo != nil {
            AppUtility.sharedInstance.removeSession(forKey: LOGIN_INFO)
            var userInfo = AppUtility.sharedInstance.getUserData(forKey: LOGIN_INFO)
            userInfo = Login()
            userInfo!.saveCurrentSession(forKey: LOGIN_INFO)
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginSBID") as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
        }
    }
}
