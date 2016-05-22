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
        
        //ユーザの誕生日を設定
        let prsn = Person.getDefaultCheckPerson()
        let spanDt = elapsedTime(Int(prsn.year)!, month: Int(prsn.month)!, day: Int(prsn.day)!)
        
        lblLifeTime.text = "\(spanDt) days"
        lblLifeTimeHour.text = "\(NSDate().hour)hour \(NSDate().minute)minute \(NSDate().second)second"
        
        //ラベルのフォントカラーにユーザが設定しているカラーを適用
        lblLifeTime.textColor = Color.getInfo(prsn.bondColor).get()
        lblLifeTimeHour.textColor = Color.getInfo(prsn.bondColor).get()
        
        //アニメーション適用
        lblLifeTime.animation = "wobble"
        lblLifeTime.animate()
    }
    
    /**
     UILabelの設定を行います。
     */
    func editText() {
        
        lblLifeTime.shadowColor = UIColor.grayColor()
        lblLifeTime.shadowOffset = CGSizeMake(6, 6)
        
        //TODO: 適用されない
        lblLifeTimeHour.shadowColor = UIColor.grayColor()
        lblLifeTimeHour.shadowOffset = CGSizeMake(8, 8)
        
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
