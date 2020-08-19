//
//  PushNotificationSender.swift
//  KolYomAyaApp
//
//  Created by Islam Abotaleb on 8/18/20.
//  Copyright © 2020 Islam Abotaleb. All rights reserved.
//

import UIKit
class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send/topics/kolyoumaya_v1_4"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "data" : ["user" : "test_id"]
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        //Authorization soon change
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAATBVC-ac:APA91bG1L5fjlhZ8ZiVbrmjWYb1N8A1vMz-myVnK7lEtfLfjs3zFFPwV-U8MPEJ-ve8JOOEyIiSqdknsCFXtqRnRV3cNpdGtya8oCtXdcEBsBKGDHZLXxU8_aXiAm34es7aIlJM7uSL3", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
