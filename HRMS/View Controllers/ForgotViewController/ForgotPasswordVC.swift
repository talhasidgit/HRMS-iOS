//
//  ForgotPasswordVC.swift
//  
//
//  Created by Ahmed on 30/12/2021.
//

import TransitionButton
import UIKit

class ForgotPasswordVC: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var getLinkButton: TransitionButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        AppUtility.bottomBorder(textfeild: emailTextField)
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func resentBtn(_ sender: Any) {
        let email = emailTextField.text
        let params = ["email": email]
        if Reachability.isConnectedToNetwork() {
            forgotApi(params: params as [String: Any])
        } else {
            CommonMethods.doSomething(view: self) {
                self.forgotApi(params: params as [String: Any])
            }
        }
    }

    @IBAction func getLinkBtn(_ sender: Any) {
        let email = emailTextField.text
        let params = ["email": email]
        if checkFieldEmpty() {
            if Reachability.isConnectedToNetwork() {
                forgotApi(params: params as [String: Any])
            } else {
                CommonMethods.doSomething(view: self) {
                    self.forgotApi(params: params as [String: Any])
                }
            }
        }
    }
    

    func forgotApi(params: [String: Any]) {
        getLinkButton.startAnimation()
        WebApi.sendOtp(params: params) { resp in
            switch resp {
            case let .success(resp):
                print(resp)

                if resp.isSuccessful! {
                    let email = self.emailTextField.text
                    AppUtility.sharedInstance.setUSerEmail(exdEmail: email ?? "")
                    self.getLinkButton.stopAnimation()
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "verifySBID") as! VerifyOTPVC
                    vc.email = email
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)

                } else {
                    self.getLinkButton.stopAnimation()
                    CommonMethods.showErrorAlert(msg: resp.responseMessage!, errorTitle: "Error")
                }

            case let .failure(error):
                print(error)
                self.getLinkButton.stopAnimation()
                CommonMethods.showErrorAlert(msg: error.localizedDescription, errorTitle: "Error")
            }
        }
    }

    func checkFieldEmpty() -> Bool {
        var valid = true

        if emailTextField.text == "" {
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Provide email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            valid = false

        } else {
            if !AppUtility.isValidEmail(testStr: emailTextField.text!) {
                emailTextField.text = ""
                emailTextField.attributedPlaceholder = NSAttributedString(string: "Email should be valid", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
                valid = false
            }
        }
        return valid
    }
}
