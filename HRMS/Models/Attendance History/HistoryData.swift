//
//  HistoryData.swift
//  MyExD
//
//  Created by Ahmed on 13/01/2022.
//

import Foundation
struct HistoryData  : Codable {
    let checkInTime : String?
    let checkOutTime : String?
    let employeeId : String?
    let date : String?

    enum CodingKeys: String, CodingKey {

        case checkInTime = "checkInTime"
        case checkOutTime = "checkOutTime"
        case employeeId = "employeeId"
        case date = "date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        checkInTime = try values.decodeIfPresent(String.self, forKey: .checkInTime)
        checkOutTime = try values.decodeIfPresent(String.self, forKey: .checkOutTime)
        employeeId = try values.decodeIfPresent(String.self, forKey: .employeeId)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}
//: Codable {
//
//    let checkInTime : String?
//    let checkOutTime : String?
//    let employeeId:String?
//    let date:String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case checkInTime = "checkInTime"
//        case checkOutTime = "checkOutTime"
//        case employeeId = "employeeId"
//        case date = "date"
//    }
//
//    init() {
//
//        checkOutTime = ""
//        checkInTime = ""
//        employeeId = ""
//        date = ""
//    }
//
//}
