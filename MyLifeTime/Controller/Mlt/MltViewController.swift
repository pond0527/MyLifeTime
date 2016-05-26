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
    
    var prsn: Person?
    /// delegate経由で画面間データ受け渡し
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backgroundImg.image = UIImage(named: "imgView.JPG")
        backgroundImg.alpha = 1.0
        
        //画面にぼかし効果適用
        let blurEfct = UIBlurEffect(style: .Light)
        let efctView = UIVisualEffectView(effect: blurEfct)
        let rect = UIScreen.mainScreen().bounds
        efctView.frame = CGRectMake(0, 0, rect.width, rect.height)
        backgroundImg.addSubview(efctView)
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        
        prsns = Person.loadAll()
        
        //ユーザに変更がない場合、アニメーションのみ適用
        if let defUser: Person = Person.getDefaultCheckPerson() {
            if let tmpPrsn = prsn {
                if defUser.id != tmpPrsn.id {
                    prsn = defUser
                    editText()
                }
            } else {
                prsn = defUser
                editText()
            }
            
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector(labelAnimate()), userInfo: nil, repeats: true)
        } else {
            showErrorMessage(msg: "デフォルトユーザを設定して下さい。")
            return
        }
    }
    
    /**
     経過時間を表示します。
     */
    func labelAnimate() {
        
        lblLifeTimeHour.text = "\(NSDate().hour)hour \(NSDate().minute)minute \(NSDate().second)second"
        
        //アニメーション適用
        lblLifeTime.animation = "wobble"
        lblLifeTime.animate()
    }
    
    /**
     UILabelの設定を行います。
     */
    func editText() {
        
        //ユーザの誕生日を設定
        var year = Int(prsn!.year)!
        var month = Int(prsn!.month)!
        var day = Int(prsn!.day)!
        
        //絆ステータスが有効 かつ Edit画面の絆ステータス有効
        if !prsn!.bondSts && appDlgt.bondSts {
            let bondPrsns = Person.getSameColorPersons(prsn!.bondColor)
            if bondPrsns.count > 1 {
                year = Int(prsn!.bondYear)!
                month = Int(prsn!.bondMonth)!
                day = Int(prsn!.bondDay)!
            }
        }
        
        let spanDt = elapsedTime(year, month: month, day: day)
        lblLifeTime.text = "\(spanDt) days"
        
        //ラベルのフォントカラーにユーザが設定しているカラーを適用
        lblLifeTime.textColor = Color.getInfo(prsn!.bondColor).get()
        lblLifeTimeHour.textColor = Color.getInfo(prsn!.bondColor).get()
        
        lblLifeTime.shadowColor = UIColor.grayColor()
        lblLifeTime.shadowOffset = CGSizeMake(6, 6)
        
        //TODO: 適用されない
        lblLifeTimeHour.shadowColor = UIColor.grayColor()
        lblLifeTimeHour.shadowOffset = CGSizeMake(8, 8)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
