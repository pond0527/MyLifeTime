//
//  EditViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class EditViewController: BaseViewController, UIToolbarDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    /// delegate経由で画面間データ受け渡し
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var lblEfctPiker: UIPickerView!
    var lblEfctToolBar:UIToolbar!
    var lblActionPiker: UIPickerView!
    var lblActionToolBar:UIToolbar!
    let springAction = SpringActionType.init()
    
    @IBOutlet weak var swchbondSts: UISwitch!
    @IBOutlet weak var txtLblEfct: UITextField!
    @IBOutlet weak var txtLblAction: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setup()
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        guard let prsn = Person.getDefaultCheckPerson() else {return}
        let bondPrsns = Person.getSameColorPersons(prsn.bondColor)
        if prsn.bondSts && bondPrsns.count > 1{
            swchbondSts.enabled = true
        } else {
            swchbondSts.enabled = false
        }
    }
    
    /**
     絆ステータス有効Switch変更時処理。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func changeBondSts(sender: AnyObject) {
        if swchbondSts.on {
            appDlgt.bondSts = true
        } else {
            appDlgt.bondSts = false
        }
    }
    
    func setup() {
        // ラベルエフェクトの設定
        lblEfctPiker = UIPickerView()
        lblEfctPiker.showsSelectionIndicator = true
        lblEfctPiker.tag = 1
        lblEfctPiker.delegate = self
        lblEfctPiker.dataSource = self
        
        // ラベルアクションの設定
        lblActionPiker = UIPickerView()
        lblActionPiker.showsSelectionIndicator = true
        lblActionPiker.tag = 2
        lblActionPiker.delegate = self
        lblActionPiker.dataSource = self
        
        lblEfctToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        lblEfctToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        lblEfctToolBar.barStyle = .BlackTranslucent
        lblEfctToolBar.tintColor = UIColor.whiteColor()
        lblEfctToolBar.backgroundColor = UIColor.blackColor()
        
        lblActionToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        lblActionToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        lblActionToolBar.barStyle = .BlackTranslucent
        lblActionToolBar.tintColor = UIColor.whiteColor()
        lblActionToolBar.backgroundColor = UIColor.blackColor()
        
        let lblEfctToolBarCompleteBtn = UIBarButtonItem(title: "完了", style: .Plain, target: self, action: #selector(EditViewController.tappedLblEfctToolBarCompleteBtn(_:)))
        let lblEfctToolBarClearBtn = UIBarButtonItem(title: "クリア", style: .Plain, target: self, action: #selector(EditViewController.tappedLblEfctClearBtn(_:)))
        let lblActionToolBarCompleteBtn = UIBarButtonItem(title: "完了", style: .Plain, target: self, action: #selector(EditViewController.tappedLblActionToolBarCompleteBtn(_:)))
        let lblActionToolBarClearBtn = UIBarButtonItem(title: "クリア", style: .Plain, target: self, action: #selector(EditViewController.tappedLblActionClearBtn(_:)))
        lblEfctToolBarCompleteBtn.tag = 1
        lblEfctToolBarClearBtn.tag = 2
        
        lblEfctToolBar.items = [lblEfctToolBarCompleteBtn, lblEfctToolBarClearBtn]
        lblActionToolBar.items = [lblActionToolBarCompleteBtn, lblActionToolBarClearBtn]
        
        txtLblEfct.inputView = lblEfctPiker
        txtLblEfct.inputAccessoryView = lblEfctToolBar
        
        txtLblAction.inputView = lblActionPiker
        txtLblAction.inputAccessoryView = lblActionToolBar
    }
    
    /**
     ピッカーに表示する列数を返す。
     
     - parameter pickerView: <#pickerView description#>
     
     - returns: <#return value description#>
     */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        var clmCnt = 0
        
        if pickerView.tag == 1 {
            clmCnt = 1
        } else if pickerView.tag == 2 {
            clmCnt = 1
        }
        
        return clmCnt
    }
    
    /**
     ピッカーに表示する行数を返す。
     
     - parameter pickerView: <#pickerView description#>
     - parameter component:  <#component description#>
     
     - returns: <#return value description#>
     */
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var rowCnt = 0
        
        if pickerView.tag == 1 {
            rowCnt = LabelEffects.count()
        } else if pickerView.tag == 2 {
            rowCnt = springAction.typeList.count
        }
        
        return rowCnt
    }
    
    // セルをビューで表示
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var lblNm = ""
        let label = UILabel(frame: CGRectMake(0, 0, pickerView.frame.width/CGFloat(5), 44))
        label.textAlignment = NSTextAlignment.Center
        
        if pickerView.tag == 1 {
            lblNm = LabelEffects.list[row].name
        } else if pickerView.tag == 2 {
            lblNm = springAction.typeList[row]
        }
        
        label.text = lblNm
        
        return label
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     ラベルエフェクト「完了」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedLblEfctToolBarCompleteBtn(sender: UIBarButtonItem) {
        txtLblEfct.resignFirstResponder()
        appDlgt.lblEfctAction = LabelEffects.getActionByStr(txtLblEfct.text!)
    }
    
    /**
     ラベルエフェクト「クリア」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedLblEfctClearBtn(sender: UIBarButtonItem) {
        txtLblEfct.text = ""
        appDlgt.lblEfctAction = LabelEffects.getActionByStr(txtLblEfct.text!)
    }
    
    /**
     ラベルエフェクト選択時。ラベルアクション選択時。
     
     - parameter pickerView: <#pickerView description#>
     - parameter row:        <#row description#>
     - parameter component:  <#component description#>
     */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            txtLblEfct.text = LabelEffects.list[row].name
        } else if pickerView.tag == 2 {
            txtLblAction.text = springAction.typeList[row]
        }
    }
    
    /**
     ラベルアクション「完了」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedLblActionToolBarCompleteBtn(sender: UIBarButtonItem) {
        txtLblAction.resignFirstResponder()
        appDlgt.lblSpringAction = txtLblAction.text!
    }
    
    /**
     ラベルアクション「クリア」押下時。
     
     - parameter sender: <#sender description#>
     */
    func tappedLblActionClearBtn(sender: UIBarButtonItem) {
        txtLblAction.text = ""
        appDlgt.lblEfctAction = LabelEffects.getActionByStr(txtLblAction.text!)
    }
}