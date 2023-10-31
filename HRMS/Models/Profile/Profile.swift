//
//  ProfileVC.swift
//  MyExD
//
//  Created by Ahmed on 14/01/2022.
//


import Foundation

struct Profile : Codable {
	let isSuccessful : Bool?
	let prodileData : ProfileData?

	enum CodingKeys: String, CodingKey {

		case isSuccessful = "isSuccessful"
		case prodileData = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		isSuccessful = try values.decodeIfPresent(Bool.self, forKey: .isSuccessful)
        prodileData = try values.decodeIfPresent(ProfileData.self, forKey: .prodileData)
	}

}
