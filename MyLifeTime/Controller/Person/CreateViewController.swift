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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        
        //delegate経由で画面間データ受け渡し
        let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.prsn = appDlgt.prsn
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     初期値を表示します。
     */
    func setup() {
        
        //ユーザ情報を編集するか判定
        if let tmpPrsn = prsn {
            
            
        }
        
    }
}
