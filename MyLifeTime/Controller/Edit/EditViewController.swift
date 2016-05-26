//
//  EditViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class EditViewController: BaseViewController {
    
    /// delegate経由で画面間データ受け渡し
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var swchbondSts: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        
        guard let prsn = Person.getDefaultCheckPerson() else {return}
        let bondPrsns = Person.getSameColorPersons(prsn.bondColor)
        if prsn.bondSts {
            swchbondSts.enabled = true
        } else {
            swchbondSts.enabled = false
        }
        
        showInfoMessage("テスト", msg: "BondPersonsカウント: \(bondPrsns.count)")
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
}