//
//  ViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import SwiftDate

class BaseViewController: UIViewController, LTMorphingLabelDelegate, UITableViewDelegate, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}

