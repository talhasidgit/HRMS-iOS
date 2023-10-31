//
//  UserInfo.swift
//  
//
//  Created by Ahmed on 11/01/2022.
//

import Foundation


struct UserInfo : Codable {
    var exd_username : String?
    var exd_password : String?
    var exd_email:String?

    enum CodingKeys: String, CodingKey {

        case exd_username = "username"
        case exd_password = "password"
        case exd_email = "email"
       
    }
    
    init(){
        exd_username = ""
        exd_password = ""
        exd_email = ""
    }
    
    func saveCurrentSession(forKey: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: forKey)
            UserDefaults.standard.synchronize()
        }
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
//        token_type = try values.decodeIfPresent(String.self, forKey: .token_type)
//        expires_in = try values.decodeIfPresent(Int.self, forKey: .expires_in)
//    }
    
    

}
