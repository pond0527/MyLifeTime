//
//  MltViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import SwiftDate

class MltViewController: BaseViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        
        // TODO: ユーザの誕生日を設定
        elapsedTime(1995, month: 2, day: 7)
        
        backgroundImg.image = UIImage(named: "imgView.JPG")
        backgroundImg.alpha = 0.6
    }
    
    /**
     経過時間を取得します。
     */
    func elapsedTime(year: Int, month: Int, day: Int) {
        
        let date = NSDate(year: year, month: month, day: day)
        
        // 経過時間の取得
        let pastTime = dtNow.timeIntervalSinceDate(date)
        
        // xxxx日
        let spanDt = Int(pastTime/60/60/24)
        
        showErrorMessage("経過時間", msg: "\(spanDt)日\(NSDate().hour)時間\(NSDate().minute)分\(NSDate().second)秒")
        
        print("経過時間：\(spanDt)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
