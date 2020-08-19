//
//  NotificationCenterDelegate.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 8/18/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
import UserNotifications
import FirebaseMessaging
import Firebase

@available(iOS 10, *)
class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    var viewModel: HomeViewModel? = HomeViewModel()

    let gcmMessageIDKey = "gcm.message_id"
    var TOPIC_GLOBAL: String = "kolyoumaya_v1_4"
    var coordinator: HomeCoordinator?

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
    coordinator = HomeCoordinator(viewController: HomeViewController())
          // Do any additional setup after loading the view.
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
              self.coordinator?.start()

          }
    completionHandler()
   
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
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          print(tokenString(deviceToken))

      }
      func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printError(error, location: error.localizedDescription)
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
}
extension NotificationCenterDelegate: MessagingDelegate {
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


    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Message Data", remoteMessage.appData)

    }
}

