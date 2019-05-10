//
//  AppDelegate.swift
//  GeoFencing_Demo
//
//  Created by LogicalWings Mac on 27/11/18.
//  Copyright © 2018 LogicalWings Mac. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var locationManager: CLLocationManager?
    var notificationCenter:UNUserNotificationCenter?
    
    static var type  = String()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        notificationCenter = UNUserNotificationCenter.current()
        notificationCenter?.delegate = self
        
        let options = UNAuthorizationOptions(arrayLiteral: [.alert,.sound])
        
        
        notificationCenter?.requestAuthorization(options: options, completionHandler: { (granted, error) in
            
            if !granted{
                print("Permission not granted")
            }
        })
        
        
        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil{
            
            
        }
        else{
            
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func handleEvent(forRegion region: CLRegion){
        
        let content = UNMutableNotificationContent()
        content.title = "Welcome to Logical Wings Infoweb PVT. LTD."
        content.body = "You have entered the Logical Wings Premises"
        content.sound = UNNotificationSound.default
        
        
        var timeinSeconds : TimeInterval = (10)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeinSeconds, repeats: false)
        
        let identifier = region.identifier
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        
        notificationCenter!.add(request) { (error) in
            if error != nil{
                print("Error adding notification with identifier: \(identifier)")
            }
        }
        
    }
    
}

extension AppDelegate : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        self.handleEvent(forRegion: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        self.handleEvent(forRegion: region)
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.notification.request.identifier
        
        print(identifier)
    }
}

