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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: デフォルトユーザーが切り替わるたび、msgが追加されている。各タブに遷移する毎に処理されている。
        guard let prsn: Person = Person.getDefaultCheckPerson() else {return}
        let birthDate = elapsedTime(Int(prsn.year)!, month: Int(prsn.month)!, day: Int(prsn.day)!)
        
        // 通知呼び出し
        var msg = "\(prsn.nm)が生まれてから \(birthDate + 1) 日 経過しました。\n"
        
        let bondPrsns = Person.getSameColorPersons(prsn.bondColor)
        if(bondPrsns.count > 1){
            let bontDate = elapsedTime(Int(prsn.bondYear)!, month: Int(prsn.bondMonth)!, day: Int(prsn.bondDay)!)
            msg += "\(bondPrsns[0].nm) と \(bondPrsns[1].nm) が出逢ってから \(bontDate + 1) 日 経過しました。"
        }
        
        notifSetting(msg)
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
    
    /*
     通知設定を行う。
     */
    func notifSetting(msg: String = "通知がありませんでした。") {
        let notif = UILocalNotification()
        notif.fireDate = NSDate.tomorrow().dateByAddingTimeInterval(60)
        notif.repeatInterval = .Day //毎日通知
        notif.timeZone = NSTimeZone.defaultTimeZone()
        notif.alertBody = msg //メッセージを入力
        notif.alertAction = "OK"
        notif.soundName = UILocalNotificationDefaultSoundName
        notif.applicationIconBadgeNumber = 1 //通知時にバッチを付ける
        notif.soundName = UILocalNotificationDefaultSoundName //通知音の設定
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
     ユーザの生年月日より現在までの経過時間を取得します。
     
     - parameter year:  年
     - parameter month: 月
     - parameter day:   日
     
     - returns: 経過日付
     */
    func elapsedTime(year: Int, month: Int, day: Int, bondFjg: Bool = false) -> Int {
        let date = NSDate(year: year, month: month, day: day)
        
        // 経過時間の取得
        let pastTime = NSDate().timeIntervalSinceDate(date)
        
        // xxxx日にフォーマット整形
        let spanDt = Int(pastTime/60/60/24)
        
        return spanDt
    }
}