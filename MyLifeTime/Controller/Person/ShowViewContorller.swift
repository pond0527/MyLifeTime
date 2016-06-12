//
//  ShowViewContorller.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

/// 　登録したユーザの一覧を表示する画面です。
class ShowViewContorller: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
        /// TableViewの最大明細行
    let TBLVIEW_DTLS_MAX = 10
        /// TableViewCellキー
    let cellId = "personList"
        /// ユーザエンティティ格納
    var prsns:[Person] = []
        /// delegate経由で画面間データ受け渡し
    let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
        /// 一覧テーブル
    @IBOutlet weak var tblPrsn: UITableView!
        /// 追加ボタン
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblPrsn.delegate = self
        tblPrsn.dataSource = self
    }
    
    /**
     自クラス呼び出し自に処理されます。
     
     - parameter animated: <#animated description#>
     */
    override func viewDidAppear(animated: Bool) {
        prsns = Person.loadAll()
        
        //ユーザ情報がない場合、初期設定を行う
        if prsns.count == 0 {
            setup()
        } else if prsns.count >= TBLVIEW_DTLS_MAX {
            btnAdd.enabled = false
        } else if prsns.count < TBLVIEW_DTLS_MAX {
            btnAdd.enabled = true
        }
        
        // 一覧を再読込
        tblPrsn.reloadData()
    }
    
    /**
     テーブルにセル数を指定する。
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: 最大明細10行
     */
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        prsns = Person.loadAll()
        return prsns.count > TBLVIEW_DTLS_MAX ? TBLVIEW_DTLS_MAX : prsns.count
    }
    
    /**
     テーブルにヘッダーを設定する。
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(table: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hdrLbl = UILabel(frame: CGRect(x:0, y:0, width: tblPrsn.bounds.width, height: 50))
        hdrLbl.text = "一覧"
        hdrLbl.font = UIFont.boldSystemFontOfSize(UIFont.labelFontSize())
        hdrLbl.textAlignment = NSTextAlignment.Center
        return hdrLbl
    }
    
    /**
     セルに値を表示する。
     */
    func tableView(table: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        prsns = Person.loadAll()
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        
        if prsns.count > 0 {
            cell.accessoryType = prsns[indexPath.row].defaultCheck ? .Checkmark : .None
            cell.textLabel?.text = prsns[indexPath.row].nm
        }
        
        return cell
    }
    
    /**
     セル選択時。
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        prsns = Person.loadAll()
        let prsn: Person = prsns[indexPath.row]
        appDlgt.prsn = prsn
        
        
        //遷移する画面を定義
        let stryBrd: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvViewController = stryBrd.instantiateViewControllerWithIdentifier("CreateViewController")
        mvViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(mvViewController, animated: true, completion: nil)
    }
    
    /**
     セルの編集モードを定義します。
     
     - parameter tableView: <#tableView description#>
     - parameter indexPath: <#indexPath description#>
     
     - returns: <#return value description#>
     */
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // デフォルト
        let edit = UITableViewRowAction(style: .Normal, title: "デフォルト") {
            (action, indexPath) in
            
            // セルの数だけループしてすべてのセルのチェックマークをはずしています。
            for i in 0..<self.prsns.count {
                let indexPath: NSIndexPath = NSIndexPath(forRow: i, inSection: indexPath.section)
                if let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath) {
                    cell.accessoryType = .None
                    Person.changeDefaultCheck(indexPath, flg: false)
                }
            }
            
            if let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath) {
                cell.accessoryType = .Checkmark
                Person.changeDefaultCheck(indexPath, flg: true)
            }
        }
        
        edit.backgroundColor = UIColor.greenColor()
        // 削除
        let del = UITableViewRowAction(style: .Default, title: "削除") {
            (action, indexPath) in
            
            self.prsns = Person.loadAll()
                
            //指定したユーザを削除
            Person.delete(self.prsns[indexPath.row].id)
            
            // TableViewを再読込
            tableView.reloadData()
            
            //ユーザ情報がない場合、初期設定を行う
            self.prsns = Person.loadAll()
            if self.prsns.count == 0 {
                self.setup()
            }
            
        }
        
        del.backgroundColor = UIColor.redColor()
        
        return [edit, del]
    }
    
    /**
     削除押下時。
     
     - parameter tableView:    <#tableView description#>
     - parameter editingStyle: <#editingStyle description#>
     - parameter indexPath:    <#indexPath description#>
     */
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 削除
        prsns = Person.loadAll()
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            //指定したユーザを削除
            Person.delete(prsns[indexPath.row].id)
            
            // TableViewを再読込
            tableView.reloadData()
            
            //ユーザ情報がない場合、初期設定を行う
            prsns = Person.loadAll()
            if prsns.count == 0 {
                setup()
            }
        }
    }
    
    /**
     初期表示の設定を行います。
     */
    func setup() {
        showInfoMessage(msg: "ユーザ情報を登録して下さい。")
        
        // showViewControllers へ遷移するために Segue を呼び出す
        performSegueWithIdentifier("showViewController",sender: nil)
    }

    /**
     追加ボタン押下時。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func tapAddBtn(sender: AnyObject) {
        // showViewControllers へ遷移するために Segue を呼び出す
        performSegueWithIdentifier("showViewController",sender: nil)
    }
    
    /**
     CreateViewControllerから遷移時。
     
     - parameter segue: <#segue description#>
     */
    @IBAction func backFromCreateView(segue:UIStoryboardSegue){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}