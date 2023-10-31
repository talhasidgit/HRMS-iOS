

import Foundation

let LOGIN_INFO = "LoginInfo"
struct Login : Codable {

	var isSuccessful : Bool?
	var responseMessage : String?
    var username : String?
    var password : String?
	let checkIn : Bool?
	let checkOut : Bool?
    var attributes : Attributes?

	enum CodingKeys: String, CodingKey {

		case isSuccessful = "isSuccessful"
		case responseMessage = "responseMessage"
		case username = "username"
		case password = "password"
		case checkIn = "checkIn"
		case checkOut = "checkOut"
		case attributes = "attributes"
	}
    
    init() {
        
     isSuccessful = false
     responseMessage = ""
     username = ""
     password = ""
     checkIn = false
     checkOut = false
     attributes = Attributes()
        
    }

    
    func saveCurrentSession(forKey: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self) {
            UserDefaults.standard.set(encoded, forKey: forKey)
            syncronizeDefaults()
        }
    }
    func storeUserInfo(token:String,customerId:Int,userId: Int,email:String,name:String,profileImage:String) {
    
        defaults.set(name, forKey: exd_username)
        defaults.set(profileImage, forKey: exd_password)
        syncronizeDefaults()
        
    }
    
    func deleteUserToken(token:String) {
        
        defaults.set(nil, forKey: "")
        syncronizeDefaults()
        
    }
    
 

}
struct forgotPassword:Codable {
    
        let isSuccessful: Bool?
        let responseMessage : String?

    
    enum CodingKeys: String, CodingKey {

        case isSuccessful = "isSuccessful"
        case responseMessage = "responseMessage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
    }
}
struct verifyOTP:Codable {
    
        let isSuccessful: Bool?
        let responseMessage : String?

    
    enum CodingKeys: String, CodingKey {

        case isSuccessful = "isSuccessful"
        case responseMessage = "responseMessage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
    }
}

struct resetPassword:Codable {
    
        let isSuccessful: Bool?
        let responseMessage : String?

    
    enum CodingKeys: String, CodingKey {

        case isSuccessful = "isSuccessful"
        case responseMessage = "responseMessage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        responseMessage = try values.decodeIfPresent(String.self, forKey: .responseMessage)
    }
}
