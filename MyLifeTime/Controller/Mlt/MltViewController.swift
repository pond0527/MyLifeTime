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
    
    /// ユーザエンティティ格納
    var prsns:[Person] = []
    //delegate経由で画面間データ受け渡し
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var lblLifeTime: SpringLabel!
    @IBOutlet weak var lblLifeTimeHour: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MltViewController.viewDidAppear), userInfo: nil, repeats: true)
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        
        prsns = Person.loadAll()
        
        // TODO: ユーザの誕生日を設定
        guard let index = appDlgt.defaultIndex else {return}
        
        let prsn = prsns[index.row]
        elapsedTime(Int(prsn.year)!, month: Int(prsn.month)!, day: Int(prsn.day)!)
        
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
        
        // xxxx日にフォーマット整形
        let spanDt = Int(pastTime/60/60/24)
        
        lblLifeTime.text = "\(spanDt)日"
        lblLifeTimeHour.text = "\(NSDate().hour)時間\(NSDate().minute)分\(NSDate().second)秒"
        lblLifeTime.animation = "flash"
        lblLifeTime.animate()
        
//        showInfoMessage("経過時間", msg: "\(spanDt)日\(NSDate().hour)時間\(NSDate().minute)分\(NSDate().second)秒", time: 20.0)
        
        print("経過時間：\(spanDt)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
