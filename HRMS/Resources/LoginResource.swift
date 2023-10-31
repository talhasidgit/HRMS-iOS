//
//  LoginResource.swift
//  
//
//  Created by Ahmed on 11/01/2022.
//
//
import Foundation
class LoginResource {
    func loginUser(url:URL,params: [String:Any],completionHandler : @escaping(Result<Login, Error>)-> Void ) {
        
        let Http = HttpClient()
        Http.postApiData(requestUrl: url, params: params, resultType: Login.self) { [self](resp) in
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
    deinit {

    }
}

