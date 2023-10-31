//
//  ResetPasswordVC.swift
//  MyExD
//
//  Created by Ahmed on 30/12/2021.
//

import UIKit

class ResetPasswordVC: UIViewController {
    var email: String?
    let iconButtonFirst = UIButton()
    let iconButtonSecond = UIButton()
    var isShowNewPassword = true
    var isShowconfirmPassword = true
    @IBOutlet var newPasswordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    @IBAction func resetBtn(_ sender: Any) {
        let password = newPasswordTextField.text

        let params = ["email": email, "password": password]

        if Reachability.isConnectedToNetwork() {
            if newPasswordTextField.text != "" && confirmPasswordTextField.text != "" {
                if newPasswordTextField.text == confirmPasswordTextField.text {
                    resetApiCall(params: params as [String: Any])

                } else {
                    CommonMethods.showErrorAlert(msg: "Password doesn't Match", errorTitle: "Warning")
                }
            } else {
                CommonMethods.showErrorAlert(msg: "Fields can't be empty", errorTitle: "Warning")
            }

        } else {
            CommonMethods.doSomething(view: self) {
                self.resetApiCall(params: params as [String: Any])
            }
        }
    }

    func resetApiCall(params: [String: Any]) {
        WebApi.resetPasswordApi(params: params as [String: Any]) { resp in
            switch resp {
            case let .success(resp):
                print(resp)

                if resp.isSuccessful! {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginSBID") as! LoginVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)

                    CommonMethods.showSuccessAlert(msg: resp.responseMessage!, success: "")
                } else {
                    CommonMethods.showErrorAlert(msg: resp.responseMessage!, errorTitle: "Error")
                }

            case let .failure(error):
                print(error)
                CommonMethods.showErrorAlert(msg: error.localizedDescription, errorTitle: "Error")
            }
        }
    }

    func setup() {
        newPasswordTextField.textFieldwithImage(direction: .Right, image: UIImage(named: " ic_Show")!, iconBtn: iconButtonFirst)

        iconButtonFirst.addTarget(self, action: #selector(showHideCurrentPassButton), for: .touchUpInside)
        confirmPasswordTextField.textFieldwithImage(direction: .Right, image: UIImage(named: " ic_Show")!, iconBtn: iconButtonSecond)

        iconButtonFirst.addTarget(self, action: #selector(showHideConfirmPassButton), for: .touchUpInside)
        AppUtility.bottomBorder(textfeild: newPasswordTextField)
        AppUtility.bottomBorder(textfeild: confirmPasswordTextField)
    }

    @objc func showHideCurrentPassButton() {
        if isShowNewPassword {
            newPasswordTextField.textFieldwithImage(direction: .Right, image: UIImage(named: "ic_Hide")!, iconBtn: iconButtonFirst)
            isShowNewPassword = false
            newPasswordTextField.isSecureTextEntry = false
        } else {
            newPasswordTextField.textFieldwithImage(direction: .Right, image: UIImage(named: " ic_Show")!, iconBtn: iconButtonFirst)
            isShowNewPassword = true
            newPasswordTextField.isSecureTextEntry = true
        }
    }

    @objc func showHideConfirmPassButton() {
        if isShowconfirmPassword {
            confirmPasswordTextField.textFieldwithImage(direction: .Right, image: UIImage(named: "ic_Hide")!, iconBtn: iconButtonSecond)
            isShowconfirmPassword = false
            confirmPasswordTextField.isSecureTextEntry = false
        } else {
            confirmPasswordTextField.textFieldwithImage(direction: .Right, image: UIImage(named: " ic_Show")!, iconBtn: iconButtonSecond)
            isShowconfirmPassword = true
            confirmPasswordTextField.isSecureTextEntry = true
        }
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
