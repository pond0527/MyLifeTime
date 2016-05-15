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
    func showInfoMessage(titleName: String = "お知らせ", msg: String) {
        
        let alertView = SCLAlertView()
        alertView.showTitle(titleName, subTitle: msg, style: SCLAlertViewStyle.Error, closeButtonTitle: "OK", duration: 5.0, colorStyle: MassageType.Error.colorInt, colorTextButton: 0xFFFFFF, circleIconImage: nil)
    }

    /**
     Editメッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter msg:       本文
     */
    func showErrorMessage(titleName: String = "エラー", msg: String) {
        
        let alertView = SCLAlertView()
        alertView.showTitle(titleName, subTitle: msg, style: SCLAlertViewStyle.Error, closeButtonTitle: "OK", duration: 5.0, colorStyle: MassageType.Error.colorInt, colorTextButton: 0xFFFFFF, circleIconImage: nil)
    }
    
    /**
     Errorメッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter fixedMsg:  固定文字列
     - parameter msgArgs:   代入文字列
     */
    func showEditMessage(titleName: String, fixedMsg: String, msgArgs: [CVarArgType]) {
        
        let alertView = SCLAlertView()
        alertView.showTitle(titleName, subTitle: NSString(format: fixedMsg, arguments: getVaList(msgArgs)) as String, style: SCLAlertViewStyle.Edit, closeButtonTitle: "OK", duration: 5.0, colorStyle: 0xA429FF, colorTextButton: 0xFFFFFF, circleIconImage: nil)
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     日付整形を行います。
     
     - parameter date:   整形対象となる日付
     - parameter format: フォーマット
     
     - returns: 整形後の日付
     */
    func dateToString(date:NSDate, format: String = "yyyy/MM/dd") -> String {
        
        let dateFormat: NSDateFormatter = NSDateFormatter()
        
        dateFormat.locale = NSLocale(localeIdentifier: "ja")
        dateFormat.dateFormat = format
        
        return dateFormat.stringFromDate(date)
    }
}

/// 絆ステータスで使用するカラーを定義します。
enum Color {
    case LightPink, LightYellow, LightGreen, LightPurple, LightGrey, White
    static let list: [Color] = [Color.LightPink, Color.LightYellow, Color.LightGreen, Color.LightPurple, Color.LightGrey, Color.White]
    
    /**
     要素のUIColorを取得します。
     
     - returns: UIColor
     */
    func get() -> UIColor {
        switch self {
        case .LightPink:
            return UIColor(red: 1.0, green: 0.8, blue: 1.0, alpha: 1.0)
        case .LightYellow:
            return UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
        case .LightGreen:
            return UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 1.0)
        case .LightPurple:
            return UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0)
        case .LightGrey:
            return UIColor(white: 0.85, alpha: 1.0)
        case .White:
            return UIColor.whiteColor()
        }
    }
    
    /**
     要素の名称を取得します。
     
     - returns: 名称
     */
    func name() -> String {
        switch self {
        case .LightPink:
            return "Pink"
        case .LightYellow:
            return "Yellow"
        case .LightGreen:
            return "Green"
        case .LightPurple:
            return "Purple"
        case .LightGrey:
            return "Grey"
        case .White:
            return ""
        }
    }
    
    /**
     要素数を取得します。
     
     - returns: 要素数
     */
    static func count() -> Int{
        return Color.list.count
    }
    
    /**
     文字列(赤,黄,etc..)からColorを取得
     
     - parameter strColor: 検索文字
     
     - returns: 対象Color情報
     */
    static func getInfo(strColor: String) -> Color {
        
        switch strColor {
        case "Green":
            return Color.LightGreen
        case "Grey":
            return Color.LightGrey
        case "Pink":
            return Color.LightPink
        case "Purple":
            return Color.LightPurple
        case "Yellow":
            return Color.LightYellow
        default:
            return Color.White
        }
    }
}

/// アラートで使用するメッセージタイプを定義します。
private enum MassageType {
    case Success, Error, Notice, Warning, Info, Edit, Wait
    
    var colorInt: UInt {
        switch self {
        case Success:
            return 0x22B573
        case Error:
            return 0xC1272D
        case Notice:
            return 0x727375
        case Warning:
            return 0xFFD110
        case Info:
            return 0x2866BF
        case Edit:
            return 0xA429FF
        case Wait:
            return 0xD62DA5
        }
        
    }
}