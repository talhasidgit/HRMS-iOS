//
//  WebApi.swift
//  ivids
//
//
//  Created by Ahmed Ayub on 06/08/2021.
//

import UIKit
import Photos


class WebApi: NSObject {
    
    static let manager = WebApi()
    static var ErrorBlock: ((_ errorTitle: String?, _ errorMessage: String?) -> Void)?
    
    func showNetworkConnectivityError() {
        WebApi.ErrorBlock!("Error","Netwrok Error" );
    }
    
    class func showServerError(with errorDesc: String?) {
        WebApi.ErrorBlock!("Error", errorDesc)
    }
    
    class func showDataFetchingError(with errorDesc: String?) {
        WebApi.ErrorBlock!("Error", errorDesc)
    }
    
    
    
    
    
    
    //MARK:- Send Otp  APi
    
    
//    class func loginApi(_ params: [String : Any ]?, withCompletionHandler completion: @escaping (_ returbObj: Login) -> Void, didFailWithError Error: @escaping (_ errorTitle: String?, _ errorMessage: String?) -> Void) {
//
        
    func loginUser(params: [String:Any],completionHandler : @escaping(Result<Login, Error>)-> Void ) {
        let urlString = BASEURL + "login"
        
        let url = URL(string: urlString)!
        print("Api url :\(urlString)")
        
        HttpClient.servicesManager.postApiData(requestUrl: url, params: params, resultType: Login.self) { (resp) in
            switch resp {
            case .success(let resp):
                print(resp as Any)
                completionHandler(.success(resp!))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        
        }
    }
        
    
    
       class func sendOtp(params: [String:Any],completionHandler : @escaping(Result<forgotPassword, Error>)-> Void ) {
            let urlString = BASEURL + "sendOtp"
            
            let url = URL(string: urlString)!
            print("Api url :\(urlString)")
            
            HttpClient.servicesManager.postForgotApi(requestUrl: url, params: params, resultType: forgotPassword.self) { (resp) in
                switch resp {
                case .success(let resp):
                    print(resp as Any)
                    completionHandler(.success(resp!))
                case .failure(let error):
                    completionHandler(.failure(error))
                    print(error)
                }
            
            
            }
            
        }
    class func verifyOtp(params: [String:Any],completionHandler : @escaping(Result<verifyOTP, Error>)-> Void ) {
         let urlString = BASEURL + "verifyOtp"
         
         let url = URL(string: urlString)!
         print("Api url :\(urlString)")
         
         HttpClient.servicesManager.postForgotApi(requestUrl: url, params: params, resultType: verifyOTP.self) { (resp) in
             switch resp {
             case .success(let resp):
                 print(resp as Any)
                 completionHandler(.success(resp!))
             case .failure(let error):
                 completionHandler(.failure(error))
                 print(error)
             }
         
         
         }
         
     }
    
    class func resetPasswordApi(params: [String:Any],completionHandler : @escaping(Result<resetPassword, Error>)-> Void ) {
         let urlString = BASEURL + "resetPassword?"
         
         let url = URL(string: urlString)!
         print("Api url :\(urlString)")
         
         HttpClient.servicesManager.postForgotApi(requestUrl: url, params: params, resultType: resetPassword.self) { (resp) in
             switch resp {
             case .success(let resp):
                 print(resp as Any)
                 completionHandler(.success(resp!))
             case .failure(let error):
                 completionHandler(.failure(error))
                 print(error)
             }
         
         
         }
         
     }
    
   class func dashboard(params: [String:Any],completionHandler : @escaping(Result<Dashboard, Error>)-> Void ) {
        let urlString = BASEURL + "getDashboardInfo"
        
        let url = URL(string: urlString)!
        print("Api url :\(urlString)")
        
        HttpClient.servicesManager.postApiData(requestUrl: url, params: params, resultType: Dashboard.self) { (resp) in
            switch resp {
            case .success(let resp):
                print(resp as Any)
                completionHandler(.success(resp!))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        
        
        }
    }

    class func checkin(params: [String:Any],completionHandler : @escaping(Result<Attendance, Error>)-> Void ) {
         let urlString = BASEURL + "markAttendance"
         
         let url = URL(string: urlString)!
         print("Api url :\(urlString)")
         
         HttpClient.servicesManager.postApiData(requestUrl: url, params: params, resultType: Attendance.self) { (resp) in
             switch resp {
             case .success(let resp):
                 print(resp as Any)
                 completionHandler(.success(resp!))
             case .failure(let error):
                 completionHandler(.failure(error))
                 print(error)
             }
         
         }
     }
    class func getHistory(params: [String:Any],completionHandler : @escaping(Result<AttendanceHistory, Error>)-> Void ) {
         let urlString = BASEURL + "getAttendanceHistory"
         
         let url = URL(string: urlString)!
         print("Api url :\(urlString)")
         
         HttpClient.servicesManager.postApiData(requestUrl: url, params: params, resultType: AttendanceHistory.self) { (resp) in
             switch resp {
             case .success(let resp):
                 print(resp as Any)
                 completionHandler(.success(resp!))
             case .failure(let error):
                 completionHandler(.failure(error))
                 print(error)
             }
         
         }
     }
    class func getProfile(params: [String:Any],completionHandler : @escaping(Result<Profile, Error>)-> Void ) {
         let urlString = BASEURL + "profile"
         
         let url = URL(string: urlString)!
         print("Api url :\(urlString)")
         
         HttpClient.servicesManager.postApiData(requestUrl: url, params: params, resultType: Profile.self) { (resp) in
             switch resp {
             case .success(let resp):
                 print(resp as Any)
                 completionHandler(.success(resp!))
             case .failure(let error):
                 completionHandler(.failure(error))
                 print(error)
             }
         
         }
     }
//        HttpClient.postRequest(input: params! as NSDictionary, urlString: urlString, token: "", completion: { (result, error) -> Void in
//            if((error) != nil)
//            {
//                Error("Error",error?.localizedDescription)
//            }
//            else
//            {
//                if(result?.object(forKey: "isSuccessful") as! Bool)
//                {
//                    print(result as Any)
//                    let fetchingError: Error? = nil
//
//                    let message = result?.object(forKey: "responseMessage") as? String
//                    let objData = result?.object(forKey: "data")
//                    let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode(Login.self, from: objData)
//
//                    if(fetchingError == nil)
//                    {
//                        completion(responseModel)
//                    }
//
//                }
//                else
//                {
//                    let error = result?.object(forKey: "errors") as? [String]
//                    Error("Error",error?.first)
//                }
//            }
//        })
    
    

       class func forgotApi(_ params: [String : Any]?, withCompletionHandler completion: @escaping (_ returbObj: String) -> Void, didFailWithError Error: @escaping (_ errorTitle: String?, _ errorMessage: String?) -> Void) {


            let urlString = BASEURL + "sendOtp"
            
            HttpClient.postRequest(input: params! as NSDictionary, urlString: urlString, token: "", completion: { (result, error) -> Void in
            if((error) != nil)
            {
                Error("Error",error?.localizedDescription)
            }
            else
            {
                if(result?.object(forKey: "isSuccessful") as! Bool)
                {
                    print(result as Any)
                    let fetchingError: Error? = nil

                    let message = result?.object(forKey: "message") as? String
                    if(fetchingError == nil)
                    {
                        completion(message!)
                    }
                }
                else
                {
                    let error = result?.object(forKey: "errors") as? [String]
                    Error("Error",error?.first)
                }
            }
        })
    }


    class func verifiyOtp(_ params: [String : Any]?, withCompletionHandler completion: @escaping (_ returbObj: String) -> Void, didFailWithError Error: @escaping (_ errorTitle: String?, _ errorMessage: String?) -> Void) {


         let urlString = BASEURL + "verifyOtp"
         
         HttpClient.postRequest(input: params! as NSDictionary, urlString: urlString, token: "", completion: { (result, error) -> Void in
         if((error) != nil)
         {
             Error("Error",error?.localizedDescription)
         }
         else
         {
             if(result?.object(forKey: "isSuccessful") as! Bool)
             {
                 print(result as Any)
                 let fetchingError: Error? = nil

                 let message = result?.object(forKey: "message") as? String
                 if(fetchingError == nil)
                 {
                     completion(message!)
                 }
             }
             else
             {
                 let error = result?.object(forKey: "errors") as? [String]
                 Error("Error",error?.first)
             }
         }
     })
 }



}
