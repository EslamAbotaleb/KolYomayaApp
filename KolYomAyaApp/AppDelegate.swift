//
//  AppDelegate.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 7/24/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import UserNotifications
import FirebaseMessaging
let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var TOPIC_GLOBAL: String = "kolyoumaya_v1_4"

    var appCoordinator: AppCoordinator?
    let notificationDelegate = NotificationCenterDelegate()
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      
        print(tokenString(deviceToken))
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printError(error, location: "Remote Notification registration")
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        if #available(iOS 10.0, *) {
            
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in
                    //                    self.printError(error, location: "Request Authorization")
                    DispatchQueue.main.async {
                        application.registerForRemoteNotifications()
                    }
            })
        } else {
       
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
        }
        UNUserNotificationCenter.current().delegate = notificationDelegate
        FirebaseApp.configure()

        Messaging.messaging().delegate = notificationDelegate
        
        Messaging.messaging().subscribe(toTopic: TOPIC_GLOBAL) { error in
            print("Subscribed to TOPIC_GLOBAL topic")
            
        }
        // will be create notification channel not found in ios soon
        let viewModel: HomeViewModel? = HomeViewModel()

        viewModel?.todayAyaApi() { [weak self] todayAyaModel in
          let content = self?.notificationContent(title: todayAyaModel.ayaObject?.suraName ?? "Notification title", body: todayAyaModel.ayaObject?.tafsir ?? "Notification body")
            print("Content\(content)")
                   }
        application.registerForRemoteNotifications()

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
        } catch let error as NSError {
            print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
        }

        window?.rootViewController = nil
        UIViewController.swizzlePresent()
        
        Localizer.DoTheSwizzling()
        Localizer.setDefaultLanguage()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        self.appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        
        return true
    }
    
    func notificationContent(title:String,body:String)->UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.userInfo = ["step":0]
        return content
    }
    
    func tokenString(_ deviceToken:Data) -> String{
        //code to make a token string
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x",byte)
        }
        return token
    }
    // A function to print errors to the console
    func printError(_ error:Error?,location:String){
        if let error = error{
            print("Error: \(error.localizedDescription) in \(location)")
        }
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
 
    
}
