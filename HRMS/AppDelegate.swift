//
//  AppDelegate.swift
//  
//
//  Created by Ahmed on 30/12/2021.
//

import UIKit
import FirebaseMessaging
import FirebaseCore
import UserNotifications

@UIApplicationMain
@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            
            guard success else{
                return
            }
            
            print("Success in APNs registry")
            DispatchQueue.main.async {
            application.registerForRemoteNotifications()
            }
        }
        
     return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else{
                return
            }
            
            print("Token is:\(token)")
        }
    }
    

    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
               return self.orientationLock
       }

    
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
