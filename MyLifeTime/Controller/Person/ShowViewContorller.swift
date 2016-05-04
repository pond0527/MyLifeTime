//
//  ShowViewContorller.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class ShowViewContorller: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let TBLVIEW_DTLS_MAX = 10                   //TableViewの最大明細行
    let cellId = "personList"
    @IBOutlet weak var tblPrson: UITableView!   //一覧テーブル
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblPrson.delegate = self
        tblPrson.dataSource = self
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
        showMessage("テスト", msg: "Personタブ")
    }
    
    /**
     テーブルにセル数を指定する
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TBLVIEW_DTLS_MAX
    }
    
    /**
     テーブルにヘッダーを設定する
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(table: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hdrLbl = UILabel(frame: CGRect(x:0, y:0, width: tblPrson.bounds.width, height: 50))
        hdrLbl.text = "一覧"
        hdrLbl.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        hdrLbl.textAlignment = NSTextAlignment.Center
        return hdrLbl
    }
    
    /**
     セルに値を表示する
     */
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // effectArea の ID で UITableViewCell のインスタンスを生成
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        //TODO:テスト表示
        cell.textLabel?.text = "テスト表示:\(indexPath.row)"
        
        return cell
    }
    
}