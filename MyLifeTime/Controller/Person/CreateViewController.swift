//
//  CreateViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class CreateViewController: BaseViewController {

        /// createViewController用ユーザ格納
    var prsn: Person?
    
        /// 画面間データ格納
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var lblSts: UILabel!
    @IBOutlet weak var swchBndSts: RAMPaperSwitch!
    @IBOutlet weak var txtNm: UITextField!
    @IBOutlet weak var slctSex: UISegmentedControl!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtDay: UITextField!
    @IBOutlet weak var txtBondYear: UITextField!
    @IBOutlet weak var txtBondMonth: UITextField!
    @IBOutlet weak var txtBondDay: UITextField!
    @IBOutlet weak var lblBondDay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
    }
    
    /**
     自クラス呼出時に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
    }
    
    /**
     自クラス終了時に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidDisappear(animated: Bool) {
        appDlgt.prsn = nil
    }
    
    /**
     初期値を表示します。
     */
    func setup() {
        
        self.prsn = appDlgt.prsn
        
        //ユーザ情報を編集するか判定
        if let editPrsn = self.prsn {
            txtNm.text = editPrsn.nm
            txtYear.text = editPrsn.year
            txtMonth.text = editPrsn.month
            txtDay.text = editPrsn.day
            let sexIndex = editPrsn.sex == "男性" ? 0 : 1
            slctSex.selectedSegmentIndex = sexIndex
            swchBndSts.setOn(editPrsn.bondSts, animated: true)
            txtBondYear.text = editPrsn.bondYear
            txtBondMonth.text = editPrsn.bondMonth
            txtBondDay.text = editPrsn.bondDay
            
            if(!editPrsn.bondColor.isEmpty) {
                
                switch editPrsn.bondColor {
                    
                case Color.LightGreen.get():
                    return swchBndSts.onTintColor = Color.LightGreen.get()
                case Color.LightGrey.get():
                    return swchBndSts.onTintColor = Color.LightGrey.get()
                case Color.LightPink.get():
                    return swchBndSts.onTintColor = Color.LightPink.get()
                case Color.LightPurple.get():
                    return swchBndSts.onTintColor = Color.LightPurple.get()
                case Color.LightYellow.get():
                    return swchBndSts.onTintColor = Color.LightYellow.get()
                default:
                    return swchBndSts.onTintColor = UIColor.whiteColor()
                }  
            }
        }
        
        controlActiveBoundSts()
    }
    
    /**
     絆ステータス変更時。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func changeBondSts(sender: AnyObject) {
        
        controlActiveBoundSts()
    }

    /**
     登録ボタン押下時。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func tapCreateBtn(sender: AnyObject) {
        
        var cratSts = "新規登録"
        
        //TODO:入力チェック実装予定
        
        //ユーザ情報を登録
        if let editPrsn = appDlgt.prsn {
            
            //編集
            cratSts = "編集登録"
            editPrsn.update({
                editPrsn.nm = self.txtNm.text!
                let index = self.slctSex.selectedSegmentIndex
                editPrsn.sex = self.slctSex.titleForSegmentAtIndex(index)!
                editPrsn.year = self.txtYear.text!
                editPrsn.month = self.txtMonth.text!
                editPrsn.day = self.txtDay.text!
                editPrsn.bondSts = self.swchBndSts.on ? true : false
                editPrsn.bondYear = self.swchBndSts.on ? self.txtBondYear.text! : ""
                editPrsn.bondMonth = self.swchBndSts.on ? self.txtBondMonth.text! : ""
                editPrsn.bondDay = self.swchBndSts.on ? self.txtBondDay.text! : ""
            })
            
            
        } else {
            
            //新規
            let newPrsn = Person.create()
            newPrsn.nm = txtNm.text!
            let index = slctSex.selectedSegmentIndex
            newPrsn.sex = slctSex.titleForSegmentAtIndex(index)!
            newPrsn.year = txtYear.text!
            newPrsn.month = txtMonth.text!
            newPrsn.day = txtDay.text!
            newPrsn.bondSts = swchBndSts.on ? true : false
            newPrsn.bondYear = swchBndSts.on ? txtBondYear.text! : ""
            newPrsn.bondMonth = swchBndSts.on ? txtBondMonth.text! : ""
            newPrsn.bondDay = swchBndSts.on ? txtBondDay.text! : ""
            newPrsn.save()
        }
        
        //遷移する画面を定義
        showMessage(cratSts, fixedMsg: "%@ 様 の%@ が完了しました。\n 一覧画面に戻ります。", msgArgs: [txtNm.text!, cratSts], method: {
            let stryBrd: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mvViewController = stryBrd.instantiateViewControllerWithIdentifier("ShowViewContorller")
            mvViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(mvViewController, animated: true, completion: nil)
        })
    }
    
    /**
     絆ステータスの状態により活性制御を行う。
     */
    func controlActiveBoundSts() {
        
        //絆ステータスの状態により活性制御を行う
        if swchBndSts.on {
            lblBondDay.hidden = false
            txtBondYear.hidden = false
            txtBondMonth.hidden = false
            txtBondDay.hidden = false
        } else {
            lblBondDay.hidden = true
            txtBondYear.hidden = true
            txtBondMonth.hidden = true
            txtBondDay.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}