//
//  AttendanceHistory.swift
//  MyExD
//
//  Created by Ahmed on 13/01/2022.
//

import Foundation
struct AttendanceHistory : Codable {
    let isSuccessful : Bool?
    let data : [HistoryData]?

    enum CodingKeys: String, CodingKey {

        case isSuccessful = "isSuccessful"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        data = try values.decodeIfPresent([HistoryData].self, forKey: .data)
    }

}


//: Codable {
//    let isSuccessful : Bool?
//    let data : [HistoryData]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case isSuccessful = "isSuccessful"
//        case data = "data"
//    }
//
//    init()  {
//
//        isSuccessful = false
//        data = [HistoryData]()
//    }
//
//}
