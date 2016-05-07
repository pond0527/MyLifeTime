//
//  SelectViewController.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/07.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class SelectViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 選択項目
    var tableData = ["項目1", "項目2"]
    
    let cellId = "selected"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 普通の省略しますが、プルダウンの選択項目のUITableViewを追加します
    }
    
    // セルが選択されたときの処理を記述します
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // グローバル変数に選択値を保持
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDelegate.selected = tableData[indexPath.row]
        
        // 元の画面に戻す
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     テーブルにセル数を指定する。
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    /**
     テーブルにヘッダーを設定する。
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(table: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "セレクト名"
    }
    
    /**
     セルに値を表示する。
     */
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        
        return cell
    }
}