//
//  Constants.swift
//  MyLifeTime
//  
//  定数を定義します。
//
//  Created by 池田哲 on 2016/05/20.
//  Copyright © 2016年 T_Pond. All rights reserved.
//

import UIKit

/// 絆ステータスで使用するカラーを定義します。
enum Color {
    case LightPink, LightYellow, LightGreen, LightPurple, LightGrey, White
    static let list: [Color] = [Color.LightPink, Color.LightYellow, Color.LightGreen, Color.LightPurple, Color.LightGrey, Color.White]
    
    /**
     要素のUIColorを取得します。
     
     - returns: UIColor
     */
    func get() -> UIColor {
        switch self {
        case .LightPink:
            return UIColor(red: 1.0, green: 0.8, blue: 1.0, alpha: 1.0)
        case .LightYellow:
            return UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
        case .LightGreen:
            return UIColor(red: 0.8, green: 1.0, blue: 0.8, alpha: 1.0)
        case .LightPurple:
            return UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0)
        case .LightGrey:
            return UIColor(white: 0.85, alpha: 1.0)
        case .White:
            return UIColor.whiteColor()
        }
    }
    
    /**
     要素の名称を取得します。
     
     - returns: 名称
     */
    func name() -> String {
        switch self {
        case .LightPink:
            return "Pink"
        case .LightYellow:
            return "Yellow"
        case .LightGreen:
            return "Green"
        case .LightPurple:
            return "Purple"
        case .LightGrey:
            return "Grey"
        case .White:
            return ""
        }
    }
    
    /**
     要素数を取得します。
     
     - returns: 要素数
     */
    static func count() -> Int{
        return Color.list.count
    }
    
    /**
     文字列(赤,黄,etc..)からColorを取得
     
     - parameter strColor: 検索文字
     
     - returns: 対象Color情報
     */
    static func getInfo(strColor: String) -> Color {
        switch strColor {
        case "Green":
            return Color.LightGreen
        case "Grey":
            return Color.LightGrey
        case "Pink":
            return Color.LightPink
        case "Purple":
            return Color.LightPurple
        case "Yellow":
            return Color.LightYellow
        default:
            return Color.White
        }
    }
}

/// アラートで使用するメッセージタイプを定義します。
enum MassageType {
    case Success, Error, Notice, Warning, Info, Edit, Wait
    
    var colorInt: UInt {
        switch self {
        case Success:
            return 0x22B573
        case Error:
            return 0xC1272D
        case Notice:
            return 0x727375
        case Warning:
            return 0xFFD110
        case Info:
            return 0x2866BF
        case Edit:
            return 0xA429FF
        case Wait:
            return 0xD62DA5
        }
    }
}

/// Springライブラリのアクションタイプを定義します。
class SpringActionType {
    var typeList: [String] = []
    let SHAKE = "shake"
    let POP = "pop"
    let MORPH = "morph"
    let SQUEEZE = "squeeze"
    let WOBBLE = "wobble"
    let SWING = "swing"
    let FLIPX = "flipX"
    let FLIPY = "flipY"
    let FALL = "fall"
    let SQUEEZE_LEFT = "squeezeLeft"
    let SQUEEZE_RIGHT = "squeezeRight"
    let SQUEEZE_DOWN = "squeezeDown"
    let SQUEEZE_UP = "squeezeUp"
    let SLIDE_LEFT = "slideLeft"
    let SLIDE_RIGHT = "slideRight"
    let SLIDE_DOWN = "slideDown"
    let SLIDE_UP = "slideUp"
    let FADE_IN = "fadeIn"
    let FADE_OUT = "fadeOut"
    let FADE_IN_Left = "fadeInLeft"
    let FADE_IN_RIGHT = "fadeInRight"
    let FADE_IN_DOWN = "fadeInDown"
    let FADE_IN_UP = "fadeInUp"
    let ZOOM_IN = "zoomIn"
    let ZOOM_OUT = "zoomOut"
    let FLASH = "flash"
    
    init() {
        typeList += ["\(SHAKE)"]
        typeList += ["\(POP)"]
        typeList += ["\(MORPH)"]
        typeList += ["\(SQUEEZE)"]
        typeList += ["\(WOBBLE)"]
        typeList += ["\(SWING)"]
        typeList += ["\(FLIPX)"]
        typeList += ["\(FLIPY)"]
        typeList += ["\(FALL)"]
        typeList += ["\(SQUEEZE_LEFT)"]
        typeList += ["\(SQUEEZE_RIGHT)"]
        typeList += ["\(SQUEEZE_DOWN)"]
        typeList += ["\(SQUEEZE_UP)"]
        typeList += ["\(SLIDE_LEFT)"]
        typeList += ["\(SLIDE_RIGHT)"]
        typeList += ["\(SLIDE_DOWN)"]
        typeList += ["\(SLIDE_UP)"]
        typeList += ["\(FADE_IN)"]
        typeList += ["\(FADE_OUT)"]
        typeList += ["\(FADE_IN_Left)"]
        typeList += ["\(FADE_IN_RIGHT)"]
        typeList += ["\(FADE_IN_DOWN)"]
        typeList += ["\(FADE_IN_UP)"]
        typeList += ["\(ZOOM_IN)"]
        typeList += ["\(ZOOM_OUT)"]
        typeList += ["\(FLASH)"]
    }
}

/**
 LTMorphingEffectライブラリのエフェクトを定義します。
 
 - Evaporate: <#Evaporate description#>
 - Fall:      <#Fall description#>
 - Pixelate:  <#Pixelate description#>
 - Sparkle:   <#Sparkle description#>
 - Scale:     <#Scale description#>
 */
enum LabelEffects {
    case Evaporate, Fall, Pixelate, Sparkle, Scale
    static let list: [LabelEffects] = [LabelEffects.Evaporate, LabelEffects.Fall, LabelEffects.Pixelate, LabelEffects.Sparkle, LabelEffects.Scale]
    
        /// 要素を取得します。
    var get: LTMorphingEffect {
        switch self {
        case Evaporate:
            return .Evaporate
        case Fall:
            return .Fall
        case Pixelate:
            return .Pixelate
        case Sparkle:
            return .Sparkle
        case Scale:
            return .Scale
        }
    }
    
    /// 要素を文字列形式で取得します。
    var name: String {
        switch self {
        case Evaporate:
            return "Evaporate"
        case Fall:
            return "Fall"
        case Pixelate:
            return "Pixelate"
        case Sparkle:
            return "Sparkle"
        case Scale:
            return "Scale"
        }
    }
    
    /**
     要素数を取得します。
     
     - returns: 要素数
     */
    static func count() -> Int{
        return LabelEffects.list.count
    }
    
    static func getActionByStr(str: String) -> LTMorphingEffect {
        switch str {
        case "Evaporate":
            return .Evaporate
        case "Fall":
            return .Fall
        case "Pixelate":
            return .Pixelate
        case "Sparkle":
            return .Sparkle
        case "Scale":
            return .Scale
        default:
            return .Evaporate
        }
    }
}