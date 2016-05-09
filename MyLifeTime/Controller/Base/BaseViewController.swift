//
//  ViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import SwiftDate

class BaseViewController: UIViewController, LTMorphingLabelDelegate {

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
     メッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter msg:       本文
     */
    func showMessage(titleName: String, msg: String) {
        
        let msgAlert = UIAlertController(title: titleName, message: msg, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler:{(action:UIAlertAction!) -> Void in })
        msgAlert.addAction(defaultAction)
        
        willMoveToParentViewController(self)
        
        //メッセージ表示
        presentViewController(msgAlert,animated: true, completion: nil)
    }
    
    /**
     メッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter fixedMsg:  固定文字列
     - parameter msgArgs:   代入文字列
     - parameter method:    ボタン押下後処理
     */
    func showMessage(titleName: String, fixedMsg: String, msgArgs: [CVarArgType], method: (() -> Void)) {
        
        let msgAlert = UIAlertController(title: titleName, message: NSString(format: fixedMsg, arguments: getVaList(msgArgs)) as String, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler:{(action:UIAlertAction!) -> Void in method()})
        msgAlert.addAction(defaultAction)
        
        willMoveToParentViewController(self)
        
        //メッセージ表示
        presentViewController(msgAlert,animated: true, completion: nil)
    }
    
    /**
     メッセージを表示します。
     
     - parameter titleName: タイトル名
     - parameter msg:       本文
     - parameter method:    ボタン押下後処理
     */
    func showMessage(titleName: String, msg: String, method: (() -> Void)) {
        
        let msgAlert = UIAlertController(title: titleName, message: msg, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: {(action:UIAlertAction!) -> Void in method()})
        msgAlert.addAction(defaultAction)
        
        willMoveToParentViewController(self)
        
        //メッセージ表示
        presentViewController(msgAlert,animated: true, completion: nil)
    }
    
    /**
     画面タッチでキーボードを閉じる。
     */
    @IBAction func tapScrn(sender: AnyObject) {
        
        //        txtName.resignFirstResponder()
        //        txtPhone.resignFirstResponder()
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
}

enum Color {
    
    case LightPink, LightYellow, LightGreen, LightPurple, LightGrey, White
    static let list: [Color] = [Color.LightPink, Color.LightYellow, Color.LightGreen, Color.LightPurple, Color.LightGrey, Color.White]
    
    /**
     要素のUIColorを取得します。
     
     - returns: <#return value description#>
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
     
     - returns: <#return value description#>
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
     
     - returns: <#return value description#>
     */
    static func count() -> Int{
        return Color.list.count
    }
}

