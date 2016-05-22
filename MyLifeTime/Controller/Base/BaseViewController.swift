//
//  ViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import SwiftDate
import SCLAlertView

class BaseViewController: UIViewController, LTMorphingLabelDelegate {
    
    let dtNow = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
    }
    
    /**
     Infoメッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter msg:       本文
     */
    func showInfoMessage(titleName: String = "お知らせ", msg: String, time: NSTimeInterval = 5.0) {
        
        let alertView = SCLAlertView()
        alertView.showTitle(titleName, subTitle: msg, style: SCLAlertViewStyle.Info, closeButtonTitle: "OK", duration: time, colorStyle: MassageType.Info.colorInt, colorTextButton: 0xFFFFFF, circleIconImage: nil)
    }

    /**
     Editメッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter msg:       本文
     */
    func showErrorMessage(titleName: String = "エラー", msg: String, time: NSTimeInterval = 5.0) {
        
        let alertView = SCLAlertView()
        alertView.showTitle(titleName, subTitle: msg, style: SCLAlertViewStyle.Error, closeButtonTitle: "OK", duration: time, colorStyle: MassageType.Error.colorInt, colorTextButton: 0xFFFFFF, circleIconImage: nil)
    }
    
    /**
     Errorメッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter fixedMsg:  固定文字列
     - parameter msgArgs:   代入文字列
     */
    func showEditMessage(titleName: String, fixedMsg: String, msgArgs: [CVarArgType], time: NSTimeInterval = 5.0) {
        
        let alertView = SCLAlertView()
        alertView.showTitle(titleName, subTitle: NSString(format: fixedMsg, arguments: getVaList(msgArgs)) as String, style: SCLAlertViewStyle.Edit, closeButtonTitle: "OK", duration: time, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: nil)
    }

    /**
     遅延処理を行います。
     
     - parameter time:  遅延時間
     - parameter block: アクション
     */
    func wait_atleast(time : NSTimeInterval, @noescape _ block: () -> Void) {
        
        let start = CFAbsoluteTimeGetCurrent()
        block()
        let end = CFAbsoluteTimeGetCurrent()
        let wait = max(0.0, time - (end - start))
        if wait > 0.0 {
            NSThread.sleepForTimeInterval(wait)
        }
    }
    
    /*
     通知設定を行う。
     */
    func notifSetting(msg: String = "テスト通知") {
        
        let notif = UILocalNotification()
        notif.fireDate = NSDate().dateByAddingTimeInterval(5) //起動して5秒後
        notif.timeZone = NSTimeZone.defaultTimeZone()
        notif.alertBody =  msg//メッセージを入力
        notif.alertAction = "OK"
        notif.soundName = UILocalNotificationDefaultSoundName
        notif.applicationIconBadgeNumber = 1 //通知時にバッチを付ける
        UIApplication.sharedApplication().scheduleLocalNotification(notif)
    }
    
    /**
     日付整形を行います。
     
     - parameter date:   整形対象となる日付
     - parameter format: フォーマット(デフォルト: yyyy/MM/dd)
     
     - returns: 整形後の日付
     */
    func dateToString(date:NSDate, format: String = "yyyy/MM/dd") -> String {
        
        let dateFormat: NSDateFormatter = NSDateFormatter()
        
        dateFormat.locale = NSLocale(localeIdentifier: "ja")
        dateFormat.dateFormat = format
        
        return dateFormat.stringFromDate(date)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     経過時間を取得します。
     
     - parameter year:  年
     - parameter month: 月
     - parameter day:   日
     
     - returns: 経過日付
     */
    func elapsedTime(year: Int, month: Int, day: Int) -> Int {
        
        let date = NSDate(year: year, month: month, day: day)
        
        // 経過時間の取得
        let pastTime = NSDate().timeIntervalSinceDate(date)
        
        // xxxx日にフォーマット整形
        let spanDt = Int(pastTime/60/60/24)
        
        return spanDt
    }
}