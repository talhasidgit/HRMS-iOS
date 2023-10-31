//
//  HistoryVC.swift
//  MyExD
//
//  Created by Ahmed on 31/12/2021.
//

import NVActivityIndicatorView
import UIKit
class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var noHistoryLbl: UILabel!
    @IBOutlet var activityIndicator: NVActivityIndicatorView!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var attendanceView: UIView!
    @IBOutlet var attendanceTableView: UITableView!
    @IBOutlet var employeeIDLbl: UILabel!

    var currentMonth: String = ""
    var currentyear: String = ""
    var apiMonth: String = ""
    let selectDate = UIDatePicker()
    var attendanceData: AttendanceHistory?
    var reverseArray: AttendanceHistory?
    let info = AppUtility.sharedInstance.getUserData(forKey: LOGIN_INFO)

    override func viewDidLoad() {
        super.viewDidLoad()

        dateTextField.withImage(direction: .Right, image: UIImage(named: "ic_calender")!)
        dateTextField.layer.borderWidth = 1.0
        dateTextField.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
        setDatePicker()

        attendanceTableView.register(UINib(nibName: "AttendanceCell", bundle: nil), forCellReuseIdentifier: "attendanceCell")
        employeeIDLbl.text = "Employe Code: \(info?.attributes?.userName ?? DefaultValue.string)"
    }

    override func viewWillAppear(_ animated: Bool) {
        dateSetup()
        if Reachability.isConnectedToNetwork() {
            getAttendance()
        } else {
            showAlert()
        }
    }

    // MARK: - UIAlert
    
    func showAlert() {
        let alert = UIAlertController(title: "", message: "No Internet connection",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Try Again",
                                      style: .cancel,
                                      handler: { [self](_: UIAlertAction!) in
            if Reachability.isConnectedToNetwork(){
                self.getAttendance()
           
            }else{
                showAlert()
               
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendanceData?.data!.count ?? DefaultValue.int
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AttendanceCell = (attendanceTableView.dequeueReusableCell(withIdentifier: "attendanceCell") as! AttendanceCell?)!
        // cell.cellView.addShadow(opacity: 0.4, cornerRadius: 0, shadowRadius: 4)
        cell.cellView.layer.borderWidth = 1
        cell.cellView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.selectionStyle = .none

        let data = attendanceData?.data!.reversed()[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let date = dateFormatter.date(from: data?.date ?? DefaultValue.string)
        dateFormatter.dateFormat = "EEE"
        let dayString = dateFormatter.string(from: date ?? DefaultValue.date)
       
        
        cell.dayLbl.text = dayString
        
        if dayString == "Sat" || dayString == "Sun" {
            cell.cellView.backgroundColor = #colorLiteral(red: 0.8660270614, green: 0.8660270614, blue: 0.8660270614, alpha: 1)
        }else{
            cell.cellView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        cell.dateLbl.text = "\(data?.date ?? DefaultValue.string)"
        let timeIn = data?.checkInTime ?? DefaultValue.string

        if timeIn == "Missed" {
            cell.timeInLbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else if timeIn == "Pending" {
            cell.timeInLbl.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else {
            cell.timeInLbl.textColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
        }
        cell.timeInLbl.text = timeIn
        let timeOut = data?.checkOutTime ?? DefaultValue.string
        
        if timeOut == "Missed" {
            cell.timeOutLbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else if timeOut == "Pending" {
            cell.timeOutLbl.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        } else {
            cell.timeOutLbl.textColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
        }
        cell.timeOutLbl.text = timeOut

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }

    func getAttendance() {
        if Reachability.isConnectedToNetwork() {
            activityIndicator.startAnimating()
            let params = [
                "username": info?.username as Any,
                "month": apiMonth,
                "year": currentyear,
            ]

            WebApi.getHistory(params: params as [String: Any]) { [self] resp in
                switch resp {
                case let .success(resp):
                    print(resp)
                    if resp.isSuccessful! {
                        attendanceData = resp

                        attendanceTableView.delegate = self
                        attendanceTableView.dataSource = self
                        attendanceTableView.reloadData()
                        noHistoryLbl.isHidden = true
                        activityIndicator.stopAnimating()
                    } else {
                        activityIndicator.stopAnimating()
                        noHistoryLbl.isHidden = false
                        CommonMethods.showNotificationAlert(msg: "No Attendance History", errorTitle: "")
                    }

                case let .failure(error):
                    print(error)
                    let st = error.localizedDescription
                    let myNumbers = st.filter { "0123456789".contains($0) }
                    
                    if myNumbers == "403" {
                        CommonMethods.showErrorAlert(msg: "Session Expired:\(myNumbers)", errorTitle: "Error")
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginSBID") as! LoginVC
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }else{
                    
                    CommonMethods.showErrorAlert(msg: st, errorTitle: "Error")
                    }
                }
            }
        }
    }

    func dateSetup() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"

        let year: String = formatter.string(from: selectDate.date)
        currentyear = year

        formatter.dateFormat = "MMM"
        let month: String = formatter.string(from: selectDate.date)

        formatter.dateFormat = "MM"
        let monthh: String = formatter.string(from: selectDate.date)

        currentMonth = month
        apiMonth = monthh
        dateTextField.text = "\(currentyear)-" + "\(currentMonth)"
    }

    func setDatePicker() {
        // Format Date
        selectDate.datePickerMode = .date
        selectDate.maximumDate = Date()

        // ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        doneButton.tintColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelButton.tintColor = #colorLiteral(red: 0.09803921569, green: 0.2598680258, blue: 0.5176470588, alpha: 1)
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = selectDate
        if #available(iOS 14, *) { // Added condition for iOS 14
            selectDate.preferredDatePickerStyle = .inline
            selectDate.sizeToFit()
        }
    }

    @objc func doneDatePicker() {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy"
        let year: String = formatter.string(from: selectDate.date)
        currentyear = year
        formatter.dateFormat = "MM"
        let month: String = formatter.string(from: selectDate.date)
        formatter.dateFormat = "MMM"
        let monthh: String = formatter.string(from: selectDate.date)
        apiMonth = month
        currentMonth = monthh
        formatter.dateFormat = "MM-yyyy"
        dateTextField.text = "\(currentyear)-" + "\(currentMonth)"
        // dateTextField.text = formatter.string(from: selectDate.date)

        getAttendance()
        view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        view.endEditing(true)
    }
}
