//
//  CreateViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class CreateViewController: BaseViewController {

    var prsn: Person?
    
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
        
        swchBndSts.onTintColor = Color.LightGrey.get()
        setup()
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     初期値を表示します。
     */
    func setup() {
        
        //delegate経由で画面間データ受け渡し
        let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.prsn = appDlgt.prsn
        
        //ユーザ情報を編集するか判定
        if let tmpPrsn = prsn {
            self.txtNm.text = tmpPrsn.nm
            self.txtYear.text = tmpPrsn.year
            self.txtMonth.text = tmpPrsn.month
            self.txtDay.text = tmpPrsn.day
            let sexIndex = tmpPrsn.sex == "男性" ? 0 : 1
            slctSex.titleForSegmentAtIndex(sexIndex)!
            self.txtBondYear.text = tmpPrsn.bondYear
            self.txtBondMonth.text = tmpPrsn.bondMonth
            self.txtBondDay.text = tmpPrsn.bondDay
        }
    }
    
    /**
     絆ステータス変更時
     
     - parameter sender: <#sender description#>
     */
    @IBAction func changeBondSts(sender: AnyObject) {
        
        if swchBndSts.on {
            self.lblBondDay.hidden = false
            self.txtBondYear.hidden = false
            self.txtBondMonth.hidden = false
            self.txtBondDay.hidden = false
        } else {
            self.lblBondDay.hidden = true
            self.txtBondYear.hidden = true
            self.txtBondMonth.hidden = true
            self.txtBondDay.hidden = true
        }
    }
    
}