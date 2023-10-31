


import UIKit
import Foundation
import Toast_Swift
import NVActivityIndicatorView
import BRYXBanner
import MaterialComponents.MaterialSnackbar
class CommonMethods: NSObject {
        
    
    
    
    static func doSomething(view:UIViewController ,actionClosure: @escaping () -> Void) {
    
        
        let action = MDCSnackbarMessageAction()
        let actionHandler = {() in
            
            actionClosure()
            
        }
        action.handler = actionHandler
        action.title = "Try Again"
        let message = MDCSnackbarMessage()
        message.action = action
        message.text = "Please check your internet!"
//        message.duration = 5.0
        MDCSnackbarManager.default.show(message)
        MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = #colorLiteral(red: 0.09901262075, green: 0.2598680258, blue: 0.5174778104, alpha: 1)
    }
   
    static func repeatedNetworkCheck(view:UIViewController ,actionClosure: @escaping () -> Void) {
    
        
        let action = MDCSnackbarMessageAction()
        let actionHandler = {() in
            
            actionClosure()
            
        }
        action.handler = actionHandler
        //action.title = "Try Again"
        let message = MDCSnackbarMessage()
        message.action = action
        message.text = "Checking your internet!"
        message.duration = 1.0
        MDCSnackbarManager.default.show(message)
        MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = #colorLiteral(red: 0.09901262075, green: 0.2598680258, blue: 0.5174778104, alpha: 1)
    }
    
    
    static func greenIndicator(connectivityIndicator:UIView){
        connectivityIndicator.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        connectivityIndicator.layer.borderWidth = 1
        connectivityIndicator.layer.cornerRadius = connectivityIndicator.layer.frame.size.width/2.0
        connectivityIndicator.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static func redIndicator(connectivityIndicator:UIView){
        connectivityIndicator.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        connectivityIndicator.layer.borderWidth = 1
        connectivityIndicator.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        connectivityIndicator.layer.cornerRadius = connectivityIndicator.layer.frame.size.width/2.0
    }
    static func orangeIndicator(connectivityIndicator:UIView){
        connectivityIndicator.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        connectivityIndicator.layer.borderWidth = 1
        connectivityIndicator.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        connectivityIndicator.layer.cornerRadius = connectivityIndicator.layer.frame.size.width/2.0
    }
    //MARK: - DATE FORMATTER
    static func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "hh:mm a"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: convertedDate!)

        return timeStamp
    }
    
    static func getTime() -> String?{
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "dd-MMM-yyyy"
        let now = Date()
        let dateString = formatter.string(from:now)
        NSLog("%@", dateString)
        return dateString
      
    }
    
    
    static func convertToBase64(str:String) -> String{
        let utf8str = str.data(using: .utf8)
         let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return base64Encoded!
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //MARK: - Show Alert
    static   func  showAlert(msg: String)  {
        let alert = UIAlertController(title: "MyExD", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))//
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        
    }
    static func showToast(msg: String) {
        var style = ToastStyle()
        style.messageColor = .white
        let color = UIColor(red: 36/255, green: 134/255, blue: 193/255, alpha: 1.0)
        style.backgroundColor = color
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .bottom, style: style)
    }
    static func showErrorMessage(msg: String) {
        var style = ToastStyle()
        style.messageColor = .white
        style.backgroundColor = .black
        UIApplication.shared.keyWindow?.makeToast(msg, duration: 3.0, position: .bottom, style: style)
    }
    static func showSuccessAlert(msg:String,success:String) {
        let banner = Banner(title: success, subtitle: msg, image: UIImage(named: ""), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
        banner.show(duration: 3.0)
    }
    static func showErrorAlert(msg:String,errorTitle:String) {
        let banner = Banner(title: errorTitle, subtitle: msg, image: UIImage(named: "error"), backgroundColor: .red)
        banner.show(duration: 3.0)
    }
    static func showNotificationAlert(msg:String,errorTitle:String) {
        let banner = Banner(title: errorTitle, subtitle: msg, image: UIImage(named: "error"), backgroundColor: UIColor(red:247.0/255.0, green:127.0/255.0, blue:12.0/255.0, alpha:1.000))
        banner.show(duration: 3.0)
    }
   static func removeSession(forKey: String){
        UserDefaults.standard.set(nil, forKey: forKey)
       UserDefaults.standard.synchronize()
    }
    
}
enum DefaultValue {
    static let string = ""
    static let float: Float = 0.0
    static let double: Double = 0.0
    static let cgfloat: CGFloat = 0.0
    static let bool: Bool = false
    static let int: Int = 0
    static let space = " "
    static let comma = ", "
    static let date : Date = Date()
    static let dateFormat = "MM/dd/yyyy"
    static let timeInterval = TimeInterval(00.00)
    static let notSet = "N/A"
}
