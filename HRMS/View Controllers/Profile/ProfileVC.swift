//
//  ProfileVC.swift
//  
//
//  Created by Ahmed on 14/01/2022.
//

import SDWebImage
import UIKit
class ProfileVC: UIViewController {
    @IBOutlet var employeeName: UITextField!
    @IBOutlet var designation: UITextField!
    @IBOutlet var employeeID: UITextField!
    @IBOutlet var employeeCode: UITextField!
    @IBOutlet var reportTo: UITextField!
    @IBOutlet var profileImage: UIImageView!
    let info = AppUtility.sharedInstance.getUserData(forKey: LOGIN_INFO)

    override func viewDidLoad() {
        super.viewDidLoad()

        AppUtility.bottomBorder(textfeild: employeeName)
        AppUtility.bottomBorder(textfeild: designation)
        AppUtility.bottomBorder(textfeild: employeeID)
        AppUtility.bottomBorder(textfeild: employeeCode)
        AppUtility.bottomBorder(textfeild: reportTo)
        profileImage.makeRounded()

        getProfile()
    }

    func getProfile() {
        let params = ["username": info?.username]
        WebApi.getProfile(params: params as [String: Any]) { [self] resp in
            switch resp {
            case let .success(resp):
                print(resp)
                if resp.isSuccessful! {
                    employeeName.text = resp.prodileData?.name
                    designation.text = resp.prodileData?.designation
                    employeeID.text = resp.prodileData?.email
                    employeeCode.text = resp.prodileData?.employeeCode
                    reportTo.text = resp.prodileData?.reportTo

                    let image = resp.prodileData?.image

                    if image != nil {
                        profileImage.sd_setImage(with: URL(string: "\(BASE_URL_IMAGE)" + image!), placeholderImage: UIImage(named: "user")) {
                            image, error, _, _ in
                            // your code
                            if error == nil {
                                profileImage.contentMode = .scaleAspectFill
                            } else {
                                profileImage.contentMode = .scaleAspectFit
                            }
                            print(image ?? "")
                        }
                    }

                } else {
                    CommonMethods.showErrorAlert(msg: "", errorTitle: "Error")
                }

            case let .failure(error):
                print(error)
                CommonMethods.showErrorAlert(msg: error.localizedDescription, errorTitle: "Warning")
            }
        }
    }
}
