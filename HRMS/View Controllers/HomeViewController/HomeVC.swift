//
//  HomeVC.swift
//  
//
//  Created by Ahmed on 31/12/2021.
//

import CoreLocation
import Network
import NVActivityIndicatorView
import UIKit

class HomeVC: UIViewController, CLLocationManagerDelegate {
    // Outlets
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var presentView: UIView!
    @IBOutlet var absentView: UIView!
    @IBOutlet var leaveView: UIView!
    @IBOutlet var presentPercentageLbl: UILabel!
    @IBOutlet var absentPercentageLbl: UILabel!
    @IBOutlet var leavePercentageLbl: UILabel!
    @IBOutlet var dateAndIDLbl: UILabel!
    @IBOutlet var employeeNameLbl: UILabel!
    @IBOutlet var employeeDesignationLbl: UILabel!
    @IBOutlet var currentTimeLbl: UILabel!
    @IBOutlet var longitudeLbl: UILabel!
    @IBOutlet var latitudeLbl: UILabel!

    // Statistics
    @IBOutlet var currentDateLbl: UILabel!
    @IBOutlet var checkInTimeLbl: UILabel!
    @IBOutlet var checkOutTimeLbl: UILabel!

    @IBOutlet var checkInButton: UIButton!
    @IBOutlet var checkOutButton: UIButton!
    @IBOutlet var remarksTextField: UITextField!
    @IBOutlet var activityIndicator: NVActivityIndicatorView!

    @IBOutlet var connectivityIndicator: UIView!
    // Variables
    var remarks:String?
    var timer = Timer()
    var data: Login?
    var currentDate: String?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var attendanceType: Int = 0
    let locationManager = CLLocationManager()
    let info = AppUtility.sharedInstance.getUserData(forKey: LOGIN_INFO)

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        AppUtility.lockOrientation(.portrait)

        monitorNetwork()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if Reachability.isConnectedToNetwork() {
            CommonMethods.greenIndicator(connectivityIndicator: connectivityIndicator)
            // setup()
            dashboardApi()
        } else {
            CommonMethods.redIndicator(connectivityIndicator: connectivityIndicator)
            showAlert()
        }
    }

    
    // MARK: - MARK ATTENDANCE

    @IBAction func checkInBtn(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            if longitudeLbl.text != "" && latitudeLbl.text != "" {
                if latitudeLbl.text == "\(0.000000)"  || longitudeLbl.text == "\(0.000000)"{
                    CommonMethods.showNotificationAlert(msg: "unable to get address", errorTitle: "Warning")
                }else{
                attendanceType = 0
                markAttendance()
                }
            } else {
                CommonMethods.showNotificationAlert(msg: "Please Allow Location Services", errorTitle: "Warning")
            }
        } else {
            showAlert()
        }
    }

    @IBAction func checkOutBtn(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            if longitudeLbl.text != "" && latitudeLbl.text != "" {
                if latitudeLbl.text == "\(0.000000)" || longitudeLbl.text == "\(0.000000)"{
                    CommonMethods.showNotificationAlert(msg: "unable to get address", errorTitle: "Warning")
                }else{
                attendanceType = 1
                markAttendance()
                }
            } else {
                CommonMethods.showNotificationAlert(msg: "Please Allow Location Services", errorTitle: "Warning")
            }

        } else {
            showAlert()
        }
    }

    
    //MARK: - MARK ATTENDANCE API
    
    func markAttendance() {
        if remarksTextField.text == ""{
             remarks = ""
        }else{
             remarks = remarksTextField.text
        }
        
        let params = [
            "username": info?.username as Any,
            "empId": info?.attributes?.userID as Any,
            "longitude": longitude as Any,
            "latitude": latitude as Any,
            "attendanceAddress": address as Any,
            "attendanceType": attendanceType,
            "attendanceSource": "Mobile Application",
            "userRemarks": remarks as Any,
        ]

        WebApi.checkin(params: params as [String: Any]) { [self] resp in
            switch resp {
            case let .success(resp):
                print(resp)
                if resp.isSuccessful! {
                    remarksTextField.text = ""
                    if resp.data?.checkIn == true {
                        if resp.data?.checkOut == true {
                            self.checkOutButton.isEnabled = false
                        } else {
                            self.checkOutButton.isEnabled = true
                        }
                        self.checkInButton.isEnabled = false
                        self.checkInButton.isHidden = true
                        dashboardApi()
                    } else {
                        self.checkInButton.isEnabled = true
                        self.checkOutButton.isEnabled = false
                        dashboardApi()
                    }
                } else {
                    if resp.data?.checkIn == nil && resp.data?.checkOut == nil{
                        CommonMethods.showErrorAlert(msg: "Please Time in First", errorTitle: "Error")
                    }else{

                    }
                }
            case let .failure(error):
                print(error)
                self.activityIndicator.stopAnimating()
                CommonMethods.orangeIndicator(connectivityIndicator: connectivityIndicator)
                let st = error.localizedDescription
                let myNumbers = st.filter { "0123456789".contains($0) }
                
                if myNumbers == "403" {
                    //CommonMethods.showErrorAlert(msg: "Session Expired:\(myNumbers)", errorTitle: "Error")
                    CommonMethods.showToast(msg: "Session Expired:\(myNumbers)")
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginSBID") as! LoginVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }else{
                
                CommonMethods.showErrorAlert(msg: st, errorTitle: "Error")
                }
            }
        }
    }

    // MARK: - DASHBOARD API

    func dashboardApi() {
        let params = ["username": info!.username!]
        activityIndicator.startAnimating()
        WebApi.dashboard(params: params as [String: Any]) { [self] resp in
            switch resp {
            case let .success(resp):
                print(resp)
                if resp.isSuccessful! {
                    dateAndIDLbl.text = "Date: \(resp.date ?? DefaultValue.string) | " + "Employee ID: \(info?.username ?? DefaultValue.notSet)"
                    currentDate = resp.date
                    currentDateLbl.text = resp.date
                    if resp.checkInTime != "" && resp.checkOutTime != "" {
                        if resp.checkInTime == "Pending" {
                            self.checkInButton.isEnabled = true
                            checkInTimeLbl.text = "Pending"
                            checkInTimeLbl.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                        } else {
                            checkInTimeLbl.text = resp.checkInTime
                            checkInTimeLbl.textColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
                            self.checkInButton.isEnabled = false
                        }
                        //check out
                        if resp.checkOutTime == "Pending" {
                            self.checkOutButton.isEnabled = true
                            checkOutTimeLbl.text = "Pending"
                            checkOutTimeLbl.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                        } else {
                            checkOutTimeLbl.textColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
                            self.checkOutButton.isEnabled = false
                            checkOutTimeLbl.text = resp.checkOutTime
                        }
                    }
                    self.activityIndicator.stopAnimating()

                } else {
                    if resp.checkInTime == "" && resp.checkOutTime == "" {
                        currentDate = resp.date
                        currentDateLbl.text = resp.date
                        self.checkOutButton.isEnabled = false
                        self.checkInButton.isEnabled = true
                        self.checkInTimeLbl.text = "Pending"
                        self.checkInTimeLbl.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                        self.checkOutTimeLbl.text = "Pending"
                        self.checkOutTimeLbl.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                    }
                    self.activityIndicator.stopAnimating()
                }

            case let .failure(error):
                print(error)
                self.activityIndicator.stopAnimating()
                CommonMethods.orangeIndicator(connectivityIndicator: connectivityIndicator)
                let st = error.localizedDescription
                let myNumbers = st.filter { "0123456789".contains($0) }
                
                if myNumbers == "403" {
                    CommonMethods.showErrorAlert(msg: "Session Expired:\(myNumbers)", errorTitle: "Error")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginSBID") as! LoginVC
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                    }
                }else{
                
                CommonMethods.showErrorAlert(msg: st, errorTitle: "Error")
                }
            }
        }
    }

    // MARK: - LOCATION MANAGER

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        getAddressFromLatLon(pdblLatitude: "\(locValue.latitude)", withLongitude: "\(locValue.longitude)")

        locationManager.stopUpdatingLocation()
        longitude = locValue.longitude
        latitude = locValue.latitude

        longitudeLbl.text = String(format: "%.6f", longitude!)
        latitudeLbl.text = String(format: "%.6f", latitude!)
    }

    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center: CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        // 21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        // 72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon

        let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)

        ceo.reverseGeocodeLocation(loc, completionHandler: { placemarks, error in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            let pm = placemarks

            if pm?.count ?? DefaultValue.int > 0 {
                let pm = placemarks![0]
                print(pm.country as Any)
                print(pm.locality as Any)
                print(pm.subLocality as Any)
                print(pm.thoroughfare as Any)
                print(pm.postalCode as Any)
                print(pm.subThoroughfare as Any)
                var addressString: String = ""
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                self.address = addressString
                print(addressString)
            }
        })
    }
    
    //MARK: - SETUP

    func setup() {
   
        remarksTextField.borderStyle = .roundedRect
        remarksTextField.layer.cornerRadius = 6
        remarksTextField.setBorderColor(width: 1, color: UIColor(red: 0.09901262075, green: 0.2598680258, blue: 0.5174778104, alpha: 1))
        leaveView.makeViewRound()
        absentView.makeViewRound()
        presentView.makeViewRound()
        profileImageView.makeRounded()
        let image = info?.attributes?.image
        if image != nil {
            profileImageView.sd_setImage(with: URL(string: "\(BASE_URL_IMAGE)" + image!), placeholderImage: UIImage(named: "user")) { [self]
                image, error, _, _ in
                // your code
                if error == nil {
                    profileImageView.contentMode = .scaleAspectFill
                } else {
                    profileImageView.contentMode = .scaleAspectFit
                }
                print(image ?? "")
            }
        }
      
        checkInButton.isEnabled = false
        checkOutButton.isEnabled = false
        employeeNameLbl.text = info?.attributes?.name
        employeeDesignationLbl.text = info?.attributes?.designation

        CommonMethods.showSuccessAlert(msg: info?.attributes?.name ?? DefaultValue.string, success: "Welcome")
        checkInButton.layer.cornerRadius = 18
        checkOutButton.layer.cornerRadius = 18
    }
    
    
    // MARK: - Network Monitor

    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [self] path in

            if path.status == .satisfied {
                DispatchQueue.main.async { [self] in
                    timer.invalidate()
                    CommonMethods.greenIndicator(connectivityIndicator: connectivityIndicator)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    showAlert()
                    CommonMethods.redIndicator(connectivityIndicator: connectivityIndicator)
                }
            }
        }

        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }

    // MARK: - UIAlert

    func showAlert() {
        let alert = UIAlertController(title: "", message: "No Internet connection", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Try Again",
                                      style: .cancel,
                                      handler: { [self] (_: UIAlertAction!) in
                                          if Reachability.isConnectedToNetwork() {
                                              self.dashboardApi()
                                              CommonMethods.greenIndicator(connectivityIndicator: connectivityIndicator)
                                          } else {
                                              showAlert()
                                              CommonMethods.redIndicator(connectivityIndicator: connectivityIndicator)
                                          }
                                      }))
        present(alert, animated: true, completion: nil)
    }

}
