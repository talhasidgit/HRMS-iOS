//
//  HttpClient.swift
//  ivids
//
//
//  Created by Ahmed on 06/08/2021.
//

import UIKit
import Alamofire

class HttpClient: NSObject {
    
    let encoding: ParameterEncoding = JSONEncoding.prettyPrinted
    static let servicesManager = HttpClient()
    
    class func postRequest(input: NSDictionary,urlString: String,token: String, completion: @escaping (NSDictionary?, NSError?) -> Void) {
        
        let url = URL(string: urlString as String)!
        
        let username =  defaults.object(forKey: exd_username)
        let password = defaults.object(forKey: exd_password)
        let headers: HTTPHeaders = [
                                     "username":"\(username ?? "")",
                                     "password":"\(password ?? "")"
                                   ]
    
        
        Alamofire.request(url, method: .post, parameters: input as? Parameters,encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                
                //to get status code
                
                if(response.result.isSuccess){
                    let result = response.result.value
                    if result == nil{
                        completion(nil ,NSError(domain: "Server error", code: 0, userInfo: [:]))
                    }
                    else{
                        let JSON = result as! NSDictionary
                        completion(JSON,nil);
                    }
                }else{
                    completion(nil ,response.result.error as NSError?);
                }
            }
    }
    
    func postApiData<T:Decodable>(requestUrl: URL, params: [String:Any], resultType: T.Type, completionHandler:@escaping(Swift.Result<T?,Error>)-> Void) {
        
        let url = requestUrl
        
        let info = AppUtility.sharedInstance.getUserData(forKey: LOGIN_INFO)
        let basicAuth = "\(info?.username ?? DefaultValue.string):" + "\(info?.password ?? DefaultValue.string)"
        let auth = CommonMethods.convertToBase64(str: basicAuth)
        
        let headers: HTTPHeaders = [ "Authorization": "Basic \(auth)"
        ]

        
     Alamofire.request(url, method: .post, parameters: params,encoding:encoding, headers: headers).validate(statusCode: 200..<300)
            .responseJSON { response in
                
                //to get status code
                switch(response.result) {
                case .success(let JSON):
                    let decoder = JSONDecoder()
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: JSON)
                        let result = try decoder.decode(T.self, from: jsonData)
                        completionHandler(.success(result))
                        print(result)
                    }
                    catch let error {
                        debugPrint("error occured while decoding = \(error)")
                        completionHandler(.failure(error))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    func postForgotApi<T:Decodable>(requestUrl: URL, params: [String:Any], resultType: T.Type, completionHandler:@escaping(Swift.Result<T?,Error>)-> Void) {
        
        let url = requestUrl

        Alamofire.request(url, method: .post, parameters: params,encoding:encoding, headers: nil)
            .responseJSON { response in
                
                //to get status code
                switch(response.result) {
                case .success(let JSON):
                    let decoder = JSONDecoder()
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: JSON)
                        let result = try decoder.decode(T.self, from: jsonData)
                        completionHandler(.success(result))
                        print(result)
                    }
                    catch let error {
                        debugPrint("error occured while decoding = \(error)")
                        completionHandler(.failure(error))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
    class func uploadMediaFileWith(input: [String:Any],urlString: String,fileKey:String,fileData : Data, completion: @escaping (NSDictionary?, NSError?) -> Void) {
        
        let url = URL(string: urlString as String)!
        
        //        var authorizationKey = String()
        //        var authorizationValue = String()
        var authHeader : HTTPHeaders = [:]
        
        //        let userToken = KUSERDEFAULTS.object(forKey: LOGIN_USER_TOKEN)
        //        authorizationKey = "Bearer \(userToken ?? "")"
        //        authorizationValue = "Authorization"
        authHeader = ["Accept":"application/json","Content-Type":"application/json"]
        //        let authHeader : HTTPHeaders = ["Content-Type":"application/json"]
        
        
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            
            for (key, value) in input {
                MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                
            }
            if (fileData != nil){
                MultipartFormData.append(fileData, withName: fileKey, fileName: "image.jpg", mimeType: "image/jpeg")
            }
            
        }, to: url, method : .post, headers : authHeader) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    let result = response.result.value
                    
                    if result == nil{
                        completion(nil ,NSError(domain: "Server error", code: 0, userInfo: [:]))
                    }
                    else{
                        let JSON = result as! NSDictionary
                        completion(JSON,nil);
                    }
                }
                
            case .failure(let encodingError):
                completion(nil ,encodingError as NSError?)
            }
        }
        
        
    }
    
    
    class func getRequest(input: NSDictionary,urlString: String , token : String, completion: @escaping (NSDictionary?, NSError?) -> Void) {
        
        let url = URL(string: urlString as String)!
        
        
        
        let header : HTTPHeaders = ["Content-Type":"application/json","token":token]
        
        
        
        Alamofire.request(url, parameters: input as? Parameters, headers: header).responseJSON { response in
            
            //to get status code
            
            if(response.result.isSuccess){
                let result = response.result.value;
                
                if result == nil{
                    completion(nil ,NSError(domain: "Server error", code: 0, userInfo: [:]))
                }
                else{
                    let JSON = result as! NSDictionary
                    completion(JSON,nil);
                }
            }else{
                completion(nil ,response.result.error as NSError?);
            }
        }
    }
    
    
    
    //MARK:- test generic api call
//    class func getRequestGeneric<T:EVObject>(input: NSDictionary,resultType :T.Type,urlString: String, completion: @escaping (NSDictionary?, NSError?) -> Void) {
        
//        let url = URL(string: urlString as String)!
//        let header : HTTPHeaders = ["Content-Type":"application/json"]
//
//        Alamofire.request(url, parameters: input as? Parameters, headers: header).responseJSON { response in
//
//
//            //to get status code
//
//            if(response.result.isSuccess){
//                let result = response.result.value;
//
//                if result == nil{
//                    completion(nil ,NSError(domain: "Server error", code: 0, userInfo: [:]))
//                }
//                else{
//                    let JSON = result as! NSDictionary
//                    completion(JSON,nil);
//                }
//            }else{
//                completion(nil ,response.result.error as NSError?);
//            }
//        }
//    }
//
    
    
    
    // MARK: - Download files Sync
    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }
    // MARK: - Download files Async
    
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        print(destinationUrl.lastPathComponent)
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
                                            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: .completeFileProtection)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
}
