//
//  Dashboard.swift
//  
//
//  Created by Ahmed on 12/01/2022.
//

import Foundation

struct Dashboard : Codable {

    var isSuccessful : Bool?
    var checkInTime : String?
    var checkOutTime : String?
    var date:String?
 

    enum CodingKeys: String, CodingKey {

        case isSuccessful = "isSuccessful"
        case checkInTime = "checkInTime"
        case checkOutTime = "checkOutTime"
        case date = "date"
 
    }
    
    init() {
        
    isSuccessful = false
    checkInTime = ""
    checkOutTime = ""
    date = ""
 
    }

 

}
