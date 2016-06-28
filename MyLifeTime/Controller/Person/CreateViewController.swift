//
//  CreateViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit
import SwiftDate

class CreateViewController: BaseViewController, UIToolbarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

        /// createViewController用ユーザ格納
    var prsn: Person?
        /// 画面間データ格納
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var dtToolBar:UIToolbar!
    var colorToolBar:UIToolbar!
    var birthDatePicker: UIDatePicker!
    var bondDatePicker: UIDatePicker!
    var colorPiker: UIPickerView!
    
    @IBOutlet weak var lblSts: UILabel!
    @IBOutlet weak var swchBndSts: RAMPaperSwitch!
    @IBOutlet weak var txtNm: UITextField!
    @IBOutlet weak var slctSex: UISegmentedControl!
    @IBOutlet weak var lblBondDay: UILabel!
    @IBOutlet weak var txtBirthDt: UITextField!
    @IBOutlet weak var txtBondDt: UITextField!
    @IBOutlet weak var txtBondColor: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        setup()
    }
    
    /**
     自クラス終了時に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidDisappear(animated: Bool) {
        appDlgt.prsn = nil
    }
    
    /**
     初期設定を行います。
     */
    func setup() {
        // 生年月日・出逢日の設定
        birthDatePicker = UIDatePicker()
        birthDatePicker.datePickerMode = UIDatePickerMode.Date
        birthDatePicker.addTarget(self, action: #selector(CreateViewController.changeBirthDate(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        bondDatePicker = UIDatePicker()
        bondDatePicker.datePickerMode = UIDatePickerMode.Date
        bondDatePicker.addTarget(self, action: #selector(CreateViewController.changeBondDate(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        dtToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        dtToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        dtToolBar.barStyle = .BlackTranslucent
        dtToolBar.tintColor = UIColor.whiteColor()
        dtToolBar.backgroundColor = UIColor.blackColor()
        
        let dtToolBarCompleteBtn = UIBarButtonItem(title: "完了", style: .Plain, target: self, action: #selector(CreateViewController.tappedDtToolBarCompleteBtn(_:)))
        dtToolBarCompleteBtn.tag = 1
        dtToolBar.items = [dtToolBarCompleteBtn]
        
        txtBirthDt.inputView = birthDatePicker
        txtBirthDt.inputAccessoryView = dtToolBar
        
        txtBondDt.inputView = bondDatePicker
        txtBondDt.inputAccessoryView = dtToolBar
        
        //色の設定
        colorPiker = UIPickerView()
        colorPiker.showsSelectionIndicator = true
        colorPiker.tag = 1
        colorPiker.delegate = self
        colorPiker.dataSource = self
        
        colorToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        colorToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        colorToolBar.barStyle = .BlackTranslucent
        colorToolBar.tintColor = UIColor.whiteColor()
        colorToolBar.backgroundColor = UIColor.blackColor()
        
        let colorToolBarCompleteBtn = UIBarButtonItem(title: "完了", style: .Plain, target: self, action: #selector(CreateViewController.tappedColorToolBarCompleteBtn(_:)))
        let colorToolBarClearBtn = UIBarButtonItem(title: "クリア", style: .Plain, target: self, action: #selector(CreateViewController.tappedDtToolBarClearBtn(_:)))
        
        colorToolBarCompleteBtn.tag = 1
        colorToolBarClearBtn.tag = 2
        colorToolBar.items = [colorToolBarCompleteBtn, colorToolBarClearBtn]
        
        txtBondColor.inputView = colorPiker
        txtBondColor.inputAccessoryView = colorToolBar
        
        txtNm.delegate = self

        //一覧画面よりエンティティを受け取る
        self.prsn = appDlgt.prsn
        
        //ユーザ情報を編集するか判定
        if let editPrsn = self.prsn {
            lblSts.text = "編集"
            
            txtNm.text = editPrsn.nm
            
            txtBirthDt.text = !editPrsn.year.isEmpty ?
                dateToString(NSDate(year: Int(editPrsn.year)!, month: Int(editPrsn.month)!, day: Int(editPrsn.day)!)) : ""
            
            birthDatePicker.date = !editPrsn.year.isEmpty ? NSDate(year: Int(editPrsn.year)!, month: Int(editPrsn.month)!, day: Int(editPrsn.day)!) : NSDate.today()
            
            slctSex.selectedSegmentIndex = editPrsn.sex == "男性" ? 0 : 1
            
            txtBondDt.text = !editPrsn.bondYear.isEmpty ?
                dateToString(NSDate(year: Int(editPrsn.bondYear)!, month: Int(editPrsn.bondMonth)!, day: Int(editPrsn.bondDay)!)) : ""
            
            bondDatePicker.date = !editPrsn.bondYear.isEmpty ? NSDate(year: Int(editPrsn.bondYear)!, month: Int(editPrsn.bondMonth)!, day: Int(editPrsn.bondDay)!) : NSDate.today()
            
            // 絆ステータスの状態により設定を行う
            if(!editPrsn.bondColor.isEmpty) {
                txtBondColor.text = editPrsn.bondColor
                swchBndSts.enabled = true
                
                swchBndSts.onTintColor = Color.getInfo(editPrsn.bondColor).get()
                self.view.backgroundColor = Color.getInfo(editPrsn.bondColor).get()
                
            } else {
                swchBndSts.enabled = false
            }
            
            swchBndSts.setOn(editPrsn.bondSts, animated: true)
            
        } else {
            lblSts.text = "新規登録"
        }
        
        controlActiveBoundSts()
    }
    
    /**
     絆ステータス(色)Pikcerに表示する列数を返す。
     
     - parameter pickerView: <#pickerView description#>
     
     - returns: <#return value description#>
     */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
     絆ステータス(色)Pikcerに表示する行数を返す。
     
     - parameter pickerView: <#pickerView description#>
     - parameter component:  <#component description#>
     
     - returns: <#return value description#>
     */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Color.count()
    }
    
    // 絆ステータス(色)Pikcerに値を設定します。
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel(frame: CGRectMake(0, 0, pickerView.frame.width/CGFloat(5), 44))
            label.text = Color.list[row].name()
            label.textAlignment = NSTextAlignment.Center
        
        return label
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
        txtBondDt.text = dateToString(bondDatePicker.date)
    }
    
    /**
     DatePiker「完了」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedDtToolBarCompleteBtn(sender: UIBarButtonItem) {
        txtBondDt.resignFirstResponder()
        txtBirthDt.resignFirstResponder()
    }
    
    /**
     絆ステータス(色)選択時。
     
     - parameter pickerView: <#pickerView description#>
     - parameter row:        <#row description#>
     - parameter component:  <#component description#>
     */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtBondColor.text = Color.list[row].name()
    }
    
    /**
     絆ステータス(色)「完了」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedColorToolBarCompleteBtn(sender: UIBarButtonItem) {
        txtBondColor.resignFirstResponder()
        
        // 存在チェック
        if Person.isSameBondColorPerson(txtBondColor.text!) {
            showErrorMessage(msg: "既に使用されている色です。\n他の色を選択してください。")
            return
        }
        
        if(txtBondColor.text!.isEmpty) {
            swchBndSts.enabled = false
            swchBndSts.onTintColor = Color.White.get()
            self.view.backgroundColor = Color.White.get()
            swchBndSts.setOn(false, animated: true)
            changeBondSts(self)
            
        } else {
            swchBndSts.enabled = true
            swchBndSts.onTintColor = Color.getInfo(txtBondColor.text!).get()
            self.view.backgroundColor = Color.getInfo(txtBondColor.text!).get()
            swchBndSts.setOn(false, animated: true)
            swchBndSts.setOn(true, animated: true)
            changeBondSts(self)
        }
    }
    
    /**
     絆ステータス(色)「クリア」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedDtToolBarClearBtn(sender: UIBarButtonItem) {
        txtBondColor.text = ""
    }
    
    /**
     絆ステータス変更時。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func changeBondSts(sender: AnyObject) {
        if !controlActiveBoundSts() {
            txtBondColor.text = ""
            swchBndSts.enabled = false
        }
    }

    /**
     登録ボタン押下時。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func tapCreateBtn(sender: AnyObject) {
        var cratSts = "新規登録"
        
        // 入力チェック
        if txtNm.text!.isEmpty {
            showErrorMessage(msg: "名前を入力して下さい")
            return
        }
        if txtBirthDt.text!.isEmpty {
            showErrorMessage(msg: "生年月日を入力して下さい")
            return
        }
        if swchBndSts.on && txtBondColor.text!.isEmpty {
            showErrorMessage(msg: "カラーを入力して下さい")
            return
        }
        if swchBndSts.on && txtBondDt.text!.isEmpty {
            showErrorMessage(msg: "出逢日を入力して下さい")
            return
        }
        
        //ユーザ情報を登録
        if let editPrsn = appDlgt.prsn {
            //編集
            cratSts = "編集"
            editPrsn.update({
                editPrsn.nm = self.txtNm.text!
                
                let index = self.slctSex.selectedSegmentIndex
                editPrsn.sex = self.slctSex.titleForSegmentAtIndex(index)!
                
                if !self.txtBirthDt.text!.isEmpty {
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
                
                editPrsn.bondColor = self.txtBondColor.text!
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
            
            newPrsn.bondColor = txtBondColor.text!
            
            newPrsn.save()
        }
        
        showEditMessage(cratSts, fixedMsg: "%@ 様 の%@ が完了しました。", msgArgs: [txtNm.text!, cratSts])
    }
    
    /**
     絆ステータスの状態により活性制御を行う。
     */
    func controlActiveBoundSts() -> Bool{
         var rsltFlg = false
        
        //絆ステータスの状態により活性制御を行う
        if swchBndSts.on {
            lblBondDay.hidden = false
            txtBondDt.hidden = false
            rsltFlg = true
        } else {
            lblBondDay.hidden = true
            txtBondDt.hidden = true
            swchBndSts.onTintColor = Color.White.get()
            self.view.backgroundColor = Color.White.get()
        }
        
        return rsltFlg
    }

    /**
     画面タッチでキーボードを閉じる。
     */
    @IBAction func tapScreen(sender: AnyObject) {
        txtNm.resignFirstResponder()
    }
    
    /**
     テキストフィールド確定押下時処理。
     
     - parameter textField: <#textField description#>
     
     - returns: <#return value description#>
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}