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
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var lblLifeTime: SpringLabel!
    @IBOutlet weak var lblLifeTimeHour: LTMorphingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MltViewController.viewDidAppear), userInfo: nil, repeats: true)
        editText()
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        
        prsns = Person.loadAll()
        
        // TODO: ユーザの誕生日を設定
        let prsn = Person.getDefaultCheckPerson()
        elapsedTime(Int(prsn.year)!, month: Int(prsn.month)!, day: Int(prsn.day)!)
        
        //ラベルのフォントカラーにデフォルトユーザに設定したしているカラーを適用
        lblLifeTime.textColor = Color.getInfo(prsn.bondColor).get()
        lblLifeTimeHour.textColor = Color.getInfo(prsn.bondColor).get()
        
        //アニメーション適用
        lblLifeTime.animation = "wobble"
        lblLifeTime.animate()
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
        
        lblLifeTime.text = "\(spanDt) days"
        lblLifeTimeHour.text = "\(NSDate().hour)hour \(NSDate().minute)minute \(NSDate().second)second"
    }
    
    /**
     UILabelの設定を行います。
     */
    func editText() {
        
        
        backgroundImg.image = UIImage(named: "imgView.JPG")
        backgroundImg.alpha = 1.0
        
        //画面にぼかし効果適用
        let blurEfct = UIBlurEffect(style: .Light)
        let efctView = UIVisualEffectView(effect: blurEfct)
        let rect = UIScreen.mainScreen().bounds
        efctView.frame = CGRectMake(0, 0, rect.width, rect.height)
        backgroundImg.addSubview(efctView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
