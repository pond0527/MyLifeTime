//
//  CreateViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import SwiftDate

class CreateViewController: BaseViewController, UIToolbarDelegate {

        /// createViewController用ユーザ格納
    var prsn: Person?
        /// 画面間データ格納
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var toolBar:UIToolbar!
    var birthDatePicker: UIDatePicker!
    var bondDatePicker: UIDatePicker!
    
    @IBOutlet weak var lblSts: UILabel!
    @IBOutlet weak var swchBndSts: RAMPaperSwitch!
    @IBOutlet weak var txtNm: UITextField!
    @IBOutlet weak var slctSex: UISegmentedControl!
    @IBOutlet weak var lblBondDay: UILabel!
    @IBOutlet weak var txtBirthDt: UITextField!
    @IBOutlet weak var txtBondDt: UITextField!

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
        
        // 生年月日の設定
        birthDatePicker = UIDatePicker()
        birthDatePicker.addTarget(self, action: #selector(CreateViewController.changeBirthDate(_:)), forControlEvents: UIControlEvents.ValueChanged)
        birthDatePicker.datePickerMode = UIDatePickerMode.Date
        txtBirthDt.inputView = birthDatePicker
        
        // 出逢日の設定
        bondDatePicker = UIDatePicker()
        bondDatePicker.addTarget(self, action: #selector(CreateViewController.changeBondDate(_:)), forControlEvents: UIControlEvents.ValueChanged)
        bondDatePicker.datePickerMode = UIDatePickerMode.Date
        txtBondDt.inputView = bondDatePicker
        
        // UIToolBarの設定
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.blackColor()
        let toolBarBtn = UIBarButtonItem(title: "完了", style: .Plain, target: self, action: #selector(CreateViewController.tappedToolBarBtn(_:)))
        toolBarBtn.tag = 1
        toolBar.items = [toolBarBtn]
        
        txtBirthDt.inputAccessoryView = toolBar
        txtBondDt.inputAccessoryView = toolBar
        
        //一覧画面よりエンティティを受け取る
        self.prsn = appDlgt.prsn
        
        //ユーザ情報を編集するか判定
        if let editPrsn = self.prsn {
            txtNm.text = editPrsn.nm
            txtBirthDt.text =
                !editPrsn.year.isEmpty ? dateToString(NSDate(year: Int(editPrsn.year)!, month: Int(editPrsn.month)!, day: Int(editPrsn.day)!)) : ""
            birthDatePicker.date = !editPrsn.year.isEmpty ? NSDate(year: Int(editPrsn.year)!, month: Int(editPrsn.month)!, day: Int(editPrsn.day)!) : NSDate.today()
            let sexIndex = editPrsn.sex == "男性" ? 0 : 1
            slctSex.selectedSegmentIndex = sexIndex
            swchBndSts.setOn(editPrsn.bondSts, animated: true)
            txtBondDt.text =
                !editPrsn.bondYear.isEmpty ? dateToString(NSDate(year: Int(editPrsn.bondYear)!, month: Int(editPrsn.bondMonth)!, day: Int(editPrsn.bondDay)!)) : ""
            bondDatePicker.date = !editPrsn.bondYear.isEmpty ? NSDate(year: Int(editPrsn.bondYear)!, month: Int(editPrsn.bondMonth)!, day: Int(editPrsn.bondDay)!) : NSDate.today()
            
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
     生年月日変更時。
     
     - parameter sender: <#sender description#>
     */
    func changeBirthDate(sender:AnyObject?){

        txtBirthDt.text = dateToString(birthDatePicker.date)
    }
    
    /**
     出逢日変更時。
     
     - parameter sender: <#sender description#>
     */
    func changeBondDate(sender:AnyObject?){
        
        txtBondDt.text = dateToString(birthDatePicker.date)
    }
    
    /**
     DatePiker「完了」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        txtBondDt.resignFirstResponder()
        txtBirthDt.resignFirstResponder()
    }
    
    /**
     日付整形を行います。
     
     - parameter date: <#date description#>
     
     - returns: <#return value description#>
     */
    func dateToString(date:NSDate) -> String {
        
        let date_formatter: NSDateFormatter = NSDateFormatter()
        
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy/MM/dd"
        
        return date_formatter.stringFromDate(date)
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
                if self.txtBirthDt.text! != "" {
                    let sprtDt = self.txtBirthDt.text!.componentsSeparatedByString("/")
                    editPrsn.year =  sprtDt[0]
                    editPrsn.month = sprtDt[1]
                    editPrsn.day = sprtDt[2]
                } else {
                    editPrsn.year =  ""
                    editPrsn.month = ""
                    editPrsn.day = ""
                }
                editPrsn.bondSts = self.swchBndSts.on ? true : false
                if self.txtBondDt.text! != "" {
                    let sprtDt = self.txtBondDt.text!.componentsSeparatedByString("/")
                    editPrsn.bondYear =  sprtDt[0]
                    editPrsn.bondMonth = sprtDt[1]
                    editPrsn.bondDay = sprtDt[2]
                } else {
                    editPrsn.bondYear =  ""
                    editPrsn.bondMonth = ""
                    editPrsn.bondDay = ""
                }
            })
            
            
        } else {
            
            //新規
            let newPrsn = Person.create()
            newPrsn.nm = txtNm.text!
            let index = slctSex.selectedSegmentIndex
            newPrsn.sex = slctSex.titleForSegmentAtIndex(index)!
            if self.txtBirthDt.text! != "" {
                let sprtDt = self.txtBirthDt.text!.componentsSeparatedByString("/")
                newPrsn.year =  sprtDt[0]
                newPrsn.month = sprtDt[1]
                newPrsn.day = sprtDt[2]
            } else {
                newPrsn.year =  ""
                newPrsn.month = ""
                newPrsn.day = ""
            }
            newPrsn.bondSts = swchBndSts.on ? true : false
            if self.txtBondDt.text! != "" {
                let sprtDt = self.txtBondDt.text!.componentsSeparatedByString("/")
                newPrsn.bondYear =  sprtDt[0]
                newPrsn.bondMonth = sprtDt[1]
                newPrsn.bondDay = sprtDt[2]
            } else {
                newPrsn.bondYear =  ""
                newPrsn.bondMonth = ""
                newPrsn.bondDay = ""
            }
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
            txtBondDt.hidden = false
        } else {
            lblBondDay.hidden = true
            txtBondDt.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}