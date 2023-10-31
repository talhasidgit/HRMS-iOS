//
//  AppConstants.swift
//  Shahalami.pk
//
//  Created by Ahmed on 08/12/2021.
//


import Foundation

let BASEURL = "http://hrms.exdnow.com:8080/hrms-exd-app/api/" //"http://203.215.173.196:8080/hrms-exd-app/api/" live url
let BASE_URL_IMAGE = "http://hrms.exdnow.com:8080/hrms-exd/hrms/images/"



class AppTheme {
    
    static var sharedInstance = AppTheme()
    //MARK: - COLORS
    var LBL_Blue        = AppUtility.sharedInstance.hexStringToUIColor(hex: "#1173BC")
    var LBL_SEP_GRAY    = AppUtility.sharedInstance.hexStringToUIColor(hex: "#dcdcdc")
    var LBL_RED         = AppUtility.sharedInstance.hexStringToUIColor(hex: "#ff2b21")
    var LBL_BLACK       = AppUtility.sharedInstance.hexStringToUIColor(hex: "#000000")
    //var LBL_WHITE       = UIColor.white
    var LBL_BLUE        = AppUtility.sharedInstance.hexStringToUIColor(hex: "#3B5998")
 //   var LBL_DARK_GRAY   = UIColor.darkGray
    var COMPLETE        = AppUtility.sharedInstance.hexStringToUIColor(hex: "#29aa62")
    var PENDING         = AppUtility.sharedInstance.hexStringToUIColor(hex: "#ff8a00")
    var CANCEL          = AppUtility.sharedInstance.hexStringToUIColor(hex: "#dd2a2a")
    var Light_Green     = AppUtility.sharedInstance.hexStringToUIColor(hex: "#7E8C01")
    var Dark_Green      = AppUtility.sharedInstance.hexStringToUIColor(hex: "#86C33E")
    var Orange          = AppUtility.sharedInstance.hexStringToUIColor(hex: "#FF6D00")
    var Gray            = AppUtility.sharedInstance.hexStringToUIColor(hex: "#BDBDBD")
    
}

let exd_username = "userName"
let exd_password = "userPassword"
let exd_email = "email"
let exd_auth = "basicAuth"
// Defaults
let defaults = UserDefaults.standard


func syncronizeDefaults() {
    
    UserDefaults.standard.synchronize()
    
}


