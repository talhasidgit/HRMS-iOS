

import Foundation
struct Attributes : Codable {
    var userID : String?
    var userName : String?
    var password : String?
    var manager : String?
    var image : String?
	let status : String?
	let date : String?
	let empDes : String?
	let brand : String?
    var dOJ : String?
	let fatherName : String?
    var department : String?
    var name : String?
    var designation : String?
    var email : String?
	var location : String?
	let medicalExp : String?
	let heads : String?
	let hRHir : String?
	let category : String?
	let fuelExp : String?
	let mobileExp : String?
	let trvRoomExp : String?
	let trvDailyExp : String?
	let trvNature : String?
	let trvMealExp : String?
	let iPDLimit : String?
	let iPDRoomLimit : String?
    var mobileNo : String?
    var cNICNo : String?
	let completionDate : String?
	let autheticationCode : String?

	enum CodingKeys: String, CodingKey {

		case userID = "UserID"
		case userName = "UserName"
		case password = "Password"
		case manager = "Manager"
		case image = "Image"
		case status = "Status"
		case date = "Date"
		case empDes = "EmpDes"
		case brand = "Brand"
		case dOJ = "DOJ"
		case fatherName = "FatherName"
		case department = "Department"
		case name = "Name"
		case designation = "Designation"
		case email = "email"
		case location = "Location"
		case medicalExp = "MedicalExp"
		case heads = "Heads"
		case hRHir = "HRHir"
		case category = "Category"
		case fuelExp = "FuelExp"
		case mobileExp = "MobileExp"
		case trvRoomExp = "TrvRoomExp"
		case trvDailyExp = "TrvDailyExp"
		case trvNature = "TrvNature"
		case trvMealExp = "TrvMealExp"
		case iPDLimit = "IPDLimit"
		case iPDRoomLimit = "IPDRoomLimit"
		case mobileNo = "MobileNo"
		case cNICNo = "CNICNo"
		case completionDate = "CompletionDate"
		case autheticationCode = "AutheticationCode"
	}

    
    init(){
     userID = ""
     userName = ""
     password = ""
     manager = ""
     image = ""
     status = ""
     date = ""
     empDes = ""
     brand = ""
     dOJ = ""
     fatherName = ""
     department = ""
     name = ""
     designation = ""
     email = ""
     location = ""
     medicalExp = ""
     heads = ""
     hRHir = ""
     category = ""
     fuelExp = ""
     mobileExp = ""
     trvRoomExp = ""
     trvDailyExp = ""
     trvNature = ""
     trvMealExp = ""
     iPDLimit = ""
     iPDRoomLimit = ""
     mobileNo = ""
     cNICNo = ""
     completionDate = ""
     autheticationCode = ""
    }
//	init(from decoder: Decoder) throws {
//		let values = try decoder.container(keyedBy: CodingKeys.self)
//		userID = try values.decodeIfPresent(String.self, forKey: .userID)
//		userName = try values.decodeIfPresent(String.self, forKey: .userName)
//		password = try values.decodeIfPresent(String.self, forKey: .password)
//		manager = try values.decodeIfPresent(String.self, forKey: .manager)
//		image = try values.decodeIfPresent(String.self, forKey: .image)
//		status = try values.decodeIfPresent(String.self, forKey: .status)
//		date = try values.decodeIfPresent(String.self, forKey: .date)
//		empDes = try values.decodeIfPresent(String.self, forKey: .empDes)
//		brand = try values.decodeIfPresent(String.self, forKey: .brand)
//		dOJ = try values.decodeIfPresent(String.self, forKey: .dOJ)
//		fatherName = try values.decodeIfPresent(String.self, forKey: .fatherName)
//		department = try values.decodeIfPresent(String.self, forKey: .department)
//		name = try values.decodeIfPresent(String.self, forKey: .name)
//		designation = try values.decodeIfPresent(String.self, forKey: .designation)
//		email = try values.decodeIfPresent(String.self, forKey: .email)
//		location = try values.decodeIfPresent(String.self, forKey: .location)
//		medicalExp = try values.decodeIfPresent(String.self, forKey: .medicalExp)
//		heads = try values.decodeIfPresent(String.self, forKey: .heads)
//		hRHir = try values.decodeIfPresent(String.self, forKey: .hRHir)
//		category = try values.decodeIfPresent(String.self, forKey: .category)
//		fuelExp = try values.decodeIfPresent(String.self, forKey: .fuelExp)
//		mobileExp = try values.decodeIfPresent(String.self, forKey: .mobileExp)
//		trvRoomExp = try values.decodeIfPresent(String.self, forKey: .trvRoomExp)
//		trvDailyExp = try values.decodeIfPresent(String.self, forKey: .trvDailyExp)
//		trvNature = try values.decodeIfPresent(String.self, forKey: .trvNature)
//		trvMealExp = try values.decodeIfPresent(String.self, forKey: .trvMealExp)
//		iPDLimit = try values.decodeIfPresent(String.self, forKey: .iPDLimit)
//		iPDRoomLimit = try values.decodeIfPresent(String.self, forKey: .iPDRoomLimit)
//		mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
//		cNICNo = try values.decodeIfPresent(String.self, forKey: .cNICNo)
//		completionDate = try values.decodeIfPresent(String.self, forKey: .completionDate)
//		autheticationCode = try values.decodeIfPresent(String.self, forKey: .autheticationCode)
//	}

}
