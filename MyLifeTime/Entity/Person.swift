//
//  Person.swift
//  MyLifeTime
//
//  Created by 池田哲 on 2016/05/03.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import Foundation
import RealmSwift

/// ユーザエンティティを管理するクラスです。
class Person: Object {
    static let realm = try! Realm()
    
    dynamic var id = 0
    dynamic var nm = ""
    dynamic var sex = ""
    dynamic var year = ""
    dynamic var month = ""
    dynamic var day = ""
    dynamic var bondSts = false
    dynamic var bondColor = ""
    dynamic var bondYear = ""
    dynamic var bondMonth = ""
    dynamic var bondDay = ""

    /*主キー*/
    override static func primaryKey() -> String? {
        return "id"
    }
    
    /**
     ユーザの新規作成を行います。
     */
    static func create() -> Person {
        let user = Person()
        user.id = lastId()
        return user
    }
    
    /**
     ユーザIDを採番します。
     */
    static func lastId () -> Int {
        if let user = realm.objects(Person).last {
            return user.id + 1
        } else {
            return 1
        }
    }
    
    /**
     全ユーザ情報を取得します。
     */
    static func loadAll() -> [Person] {
        let userList = realm.objects(Person).sorted("id", ascending: true)
        var rslt: [Person] = []
        for user in userList {
            rslt.append(user)
        }
        return rslt
    }

    /**
     保存処理を行います。
     */
    func save() {
        try! Person.realm.write {
            Person.realm.add(self)
        }
    }
    
    /**
     更新処理を行います。
     */
    func update(method: (() -> Void)) {
        try! Person.realm.write {
            method()
        }
    }

    /**
     フィルター検索を行います。
     
     - parameter srchNm:    ユーザ名
     - parameter srchSex:   性別
     - parameter srchPhone: 電話番号
     
     - returns: <#return value description#>
     */
    static func searchUsers(srchNm: String?, srchSex: String?, srchPhone: String?) -> Results<Person> {
        
        //検索条件をNSPredicateで作成
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.OrPredicateType
            , subpredicates: [
                NSPredicate(format: "nm = %@", srchNm!),
                NSPredicate(format: "sex = %@", srchSex!),
                NSPredicate(format: "phone = %@", srchPhone!),
            ])
        
        let result = realm.objects(Person).filter(predicate)
        return result
    }
    
    /**
     全ユーザ情報を削除します。
     */
    static func deleteAll() {
        
        // 指定されたセルのオブジェクトをユーザ情報から削除
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    /**
     ユーザIDを指定してユーザを削除します。
     
     - parameter id: ユーザID
     */
    static func delete(id: Int?) {
        
        // 指定されたセルのオブジェクトをユーザ情報から削除
        let predicate = NSPredicate(format: "id = %d", id!)
        let user = realm.objects(Person).filter(predicate)
        try! realm.write {
            realm.delete(user)
        }
    }
}