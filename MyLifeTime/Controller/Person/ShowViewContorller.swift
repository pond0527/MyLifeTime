//
//  ShowViewContorller.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

class ShowViewContorller: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
        /// TableViewの最大明細行
    let TBLVIEW_DTLS_MAX = 10
        /// TableViewCellキー
    let cellId = "personList"
        /// ユーザエンティティ格納
    var prsns:[Person] = []
    
    @IBOutlet weak var tblPrsn: UITableView!   //一覧テーブル
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblPrsn.delegate = self
        tblPrsn.dataSource = self
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
        
        prsns = Person.loadAll()
        
        //ユーザ情報がない場合、初期設定を行う
        if prsns.count == 0 {
            setup()
        }
    }
    
    /**
     テーブルにセル数を指定する。
     
     - parameter table:   <#table description#>
     - parameter section: <#section description#>
     
     - returns: <#return value description#>
     */
    func tableView(table: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        prsns = Person.loadAll()
        return prsns.count
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
        
        //delegate経由で画面間データ受け渡し
        let appDlgt: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDlgt.prsn = prsn
        
        
        //遷移する画面を定義
        let stryBrd: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvViewController = stryBrd.instantiateViewControllerWithIdentifier("CreateViewController")
        mvViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(mvViewController, animated: true, completion: nil)
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
            
            //指定してユーザを削除
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
        
        //初期ユーザ登録用アラートダイアログ生成
        let usrAlert: UIAlertController = UIAlertController(title: "あなたの情報を入力してください", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        //アクション定義
        let defaultAction: UIAlertAction =
            UIAlertAction(title: "登録", style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) -> Void in self.create(usrAlert)})
        
        usrAlert.addAction(defaultAction)
        
        //テキストフィールド追加
        usrAlert.addTextFieldWithConfigurationHandler({(usrNm:UITextField!) -> Void in usrNm.placeholder = "氏名"})
        usrAlert.addTextFieldWithConfigurationHandler({(usrSex:UITextField!) -> Void in usrSex.placeholder = "性別(男性or女性)"})
        usrAlert.addTextFieldWithConfigurationHandler({(usrYear:UITextField!) -> Void in usrYear.placeholder = "年(yyyy)"})
        usrAlert.addTextFieldWithConfigurationHandler({(usrMonth:UITextField!) -> Void in usrMonth.placeholder = "月(mm)"})
        usrAlert.addTextFieldWithConfigurationHandler({(userDay:UITextField!) -> Void in userDay.placeholder = "日(dd)"})
        
        presentViewController(usrAlert,animated: true, completion: nil)
    }

    /**
     追加ボタン押下時。
     
     - parameter sender: <#sender description#>
     */
    @IBAction func tapAddBtn(sender: AnyObject) {
        
        //遷移する画面を定義
        let stryBrd: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mvViewController = stryBrd.instantiateViewControllerWithIdentifier("CreateViewController")
        mvViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(mvViewController, animated: true, completion: nil)
    }
    
    /**
     ユーザ情報を登録します。
     */
    func create(usr: UIAlertController) {
        
        //TODO:入力チェック実装予定
        
        //ユーザ情報を登録
        let prsn = Person.create()
        prsn.nm = usr.textFields![0].text!
        prsn.sex = usr.textFields![1].text!
        prsn.year = usr.textFields![2].text!
        prsn.month = usr.textFields![3].text!
        prsn.day = usr.textFields![4].text!
        prsn.bondSts = false
        prsn.save()
        
        tblPrsn.reloadData()
        
    }
}