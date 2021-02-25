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
import GoogleMobileAds
let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,GADInterstitialDelegate {
    
    var window: UIWindow?
    var TOPIC_GLOBAL: String = "kolyoumaya_v1_4"
    let gcmMessageIDKey = "gcm.message_id"
    var coordinator: HomeCoordinator?
    var viewModel: HomeViewModel? = HomeViewModel()
    var gViewController: UIViewController?
    var mInterstitial: GADInterstitial!
    var appCoordinator: AppCoordinator?
//    let notificationDelegate = NotificationCenterDelegate()
    
  
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.alert, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo
      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print full message.
      print(userInfo)
       //moveToNextViewController()
//        appCoordinator = HomeCoordinator(viewController: HomeViewController())
            // Do any additional setup after loading the view.
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.appCoordinator?.start()

            }
      completionHandler()
     
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      
        print(tokenString(deviceToken))
        Messaging.messaging().apnsToken = deviceToken

    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printError(error, location: "Remote Notification registration")
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        GADMobileAds.sharedInstance().start(completionHandler: nil)
     
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers =
            [ "e9065fe7c6def84f2f1923ff90933c95" ]
      //  d8e301fd8e1586814a4929564ce8b288
//        2077ef9a63d2b398840261c8221a0c9b
        FirebaseApp.configure()

        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        Messaging.messaging().subscribe(toTopic: TOPIC_GLOBAL) { error in
                  print("Subscribed to TOPIC_GLOBAL topic\(error)")
            
              }
        
        
        if #available(iOS 10.0, *) {
            
//            UNUserNotificationCenter.current().delegate = self
//
//            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//            UNUserNotificationCenter.current().requestAuthorization(
//                options: authOptions,
//                completionHandler: {_, _ in
//                    //                    self.printError(error, location: "Request Authorization")
//                    DispatchQueue.main.async {
//                        application.registerForRemoteNotifications()
//                    }
//            })
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.sound,.alert]
            UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions,
              completionHandler: {granted, error in
                  if error != nil {
                      self.printError(error, location: error!.localizedDescription)
                  } else {
                      print("grantedgranted\(granted)")
                    
                  }
                  
            })
        } else {
       
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//
//            application.registerUserNotificationSettings(settings)
            
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            
        }
//        UNUserNotificationCenter.current().delegate = notificationDelegate
//        FirebaseApp.configure()
//
//        Messaging.messaging().delegate = notificationDelegate
//
//        Messaging.messaging().subscribe(toTopic: TOPIC_GLOBAL) { error in
//            print("Subscribed to TOPIC_GLOBAL topic")
//
//        }
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
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
      }

      func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification

        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)

        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        completionHandler(UIBackgroundFetchResult.newData)
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
    func notificationContent(title:String,body:String)->UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.userInfo = ["step":0]
        return content
    }
    
//    func tokenString(_ deviceToken:Data) -> String{
//        //code to make a token string
//        let bytes = [UInt8](deviceToken)
//        var token = ""
//        for byte in bytes{
//            token += String(format: "%02x",byte)
//        }
//        return token
//    }
//    // A function to print errors to the console
//    func printError(_ error:Error?,location:String){
//        if let error = error{
//            print("Error: \(error.localizedDescription) in \(location)")
//        }
//    }
    
    
    
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
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
      print("Firebase registration token: \(fcmToken)")

      let dataDict:[String: String] = ["token": fcmToken]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        let sender = PushNotificationSender()

        self.viewModel?.todayAyaApi() { [weak self] todayAyaModel in
            sender.sendPushNotification(to: fcmToken, title: todayAyaModel.ayaObject?.suraName ?? "Notification title", body: todayAyaModel.ayaObject?.tafsir ?? "Notification body")

            }
        
        
//                            sender.sendPushNotification(to: fcmToken, title: "Notification title", body: "Notification body")
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

//
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Message Data", remoteMessage.appData)
//
//    }
}
