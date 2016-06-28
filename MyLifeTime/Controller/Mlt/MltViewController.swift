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
        
        // タイマーを設定
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MltViewController.showTime), userInfo: nil, repeats: true)
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(MltViewController.animateLabel), userInfo: nil, repeats: true)
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        prsns = Person.loadAll()
        
        // ユーザに変更がない場合、アニメーションのみ適用
        guard let defUser: Person = Person.getDefaultCheckPerson() else {
            showErrorMessage(msg: "デフォルトユーザを設定して下さい。")
            return
        }
        
        if let tmpPrsn = prsn {
            // 既にデフォルトユーザが設定済み かつ デフォルトユーザが変更された場合
            if defUser.id != tmpPrsn.id {
                prsn = defUser
            }
            
        } else {
            // デフォルトユーザが未設定 かつ デフォルトユーザが設定された場合
            prsn = defUser
        }
        
        editText()
    }
    
    /**
     経過時間を表示します。
     */
    func showTime() {
        lblLifeTimeHour.text = "\(NSDate().hour)hour \(NSDate().minute)minute \(NSDate().second)second"
    }
    
    /**
     アニメーションを適用します。
     */
    func animateLabel(sender: NSTimer) {
        // Springアニメーション適用
        lblLifeTime.animation = appDlgt.lblSpringAction
        lblLifeTime.animateTo()
        
        // エフェクト適用
        lblLifeTimeHour.morphingEffect = appDlgt.lblEfctAction
    }
    
    
    /**
     UILabelの設定を行います。
     */
    func editText() {
        // ユーザの誕生日を設定
        var year = Int(prsn!.year)!
        var month = Int(prsn!.month)!
        var day = Int(prsn!.day)!
        
        // 絆ステータスが有効 かつ Edit画面の絆ステータス有効
        if prsn!.bondSts && appDlgt.bondSts {
            if Person.isSameBondColorPerson(prsn!.bondColor) {
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
        
        // 影を適用
        lblLifeTime.shadowColor = UIColor.grayColor()
        lblLifeTime.shadowOffset = CGSizeMake(6, 6)
        
        // 背景画像設定
        let (img, edit) = appDlgt.imgSlctView
        backgroundImg.alpha = 1.0
        
        if !edit {
            removeSubView(backgroundImg)
            backgroundImg.image = BaseConstants.IMG_VIEW
            
            // 画面にぼかし効果適用
            let blurEfct = UIBlurEffect(style: .Light)
            let efctView = UIVisualEffectView(effect: blurEfct)
            let rect = UIScreen.mainScreen().bounds
            efctView.frame = CGRectMake(0, 0, rect.width, rect.height)
            
            self.backgroundImg.addSubview(efctView)
            
        } else {
            backgroundImg.image = img
            
            // ぼかしを削除
            removeSubView(backgroundImg)
        }
    }
    
    /**
     ViewのSubViewを削除します。
     
     - parameter view: View
     */
    private func removeSubView(view: UIImageView) {
        for subView in view.subviews {
            subView.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
