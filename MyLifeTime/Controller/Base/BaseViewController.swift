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
    
    case LightPink, LightYellow, LightGreen, LightPurple, LightGrey
        
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
        }
    }
}

