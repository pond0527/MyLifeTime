//
//  AppDelegate.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import SCLAlertView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var prsn: Person?
    var bondSts = false
    var lblEfctAction: LTMorphingEffect = LabelEffects.Evaporate.get
    var lblSpringAction = SpringActionType.init().WOBBLE
    var imgSlctView = (BaseConstants.IMG_VIEW, false) // TODO:変更フラグも付加したい
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //Realmマイグレーション(カラムを追加)
        Realm.Configuration.defaultConfiguration = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                
                migration.enumerate(Person.className()) { oldObject, newObject in
                    
                    if oldSchemaVersion < 1 {
                        newObject?["bondColor"] = ""
                        newObject?["bondYear"] = ""
                        newObject?["bondMonth"] = ""
                        newObject?["bondDay"] = ""
                        newObject?["defaultCheck"] = false
                    }
                }
        })
        
        // アラート表示の許可をもらう.
        let setting = UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        
        //アプリ起動前の通知を受け取る
        if let notify = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey] {
            // アプリが起動していない時にpush通知が届き、push通知から起動した場合
            print(notify.alertBody)
        }
        
        //バッジを0にする
        application.applicationIconBadgeNumber = 0
        return true
    }
    
    // Push通知受信時とPush通知をタッチして起動したときに呼ばれる
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        let baseView = BaseViewController()
        
        switch application.applicationState {
        case .Inactive:
            // アプリがバックグラウンドにいる状態で、Push通知から起動したとき
            // バッジを0にする
            application.applicationIconBadgeNumber = 0
            // 通知領域から削除
            application.cancelLocalNotification(notification)
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            break
        case .Active:
            // アプリ起動時にPush通知を受信したとき
            baseView.showInfoMessage("通知があります。" ,msg: notification.alertBody!)
            // バッジを0にする
            application.applicationIconBadgeNumber = 0
            
            // 通知領域から削除
            application.cancelLocalNotification(notification)
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            break
        case .Background:
            // アプリがバックグラウンドにいる状態でPush通知を受信したとき
            break
        }
    }
    
    // Push通知が利用不可であればerrorが返ってくる
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("Push通知エラー: 利用不可です。" + "\(error)")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    // アプリを閉じるときに通過
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        //古い通知があれば削除する
//       application.cancelAllLocalNotifications()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.Pond.MyLifeTime" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("MyLifeTime", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

