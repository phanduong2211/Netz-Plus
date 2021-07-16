//
//  Handy.swift
//  TasReference
//
//  Created by nextage on 2019/12/12.
//  Copyright © 2019 nextage. All rights reserved.
//

import UIKit
private var _maxLengths = [UITextField : Int]()
extension UITextField{
    @IBInspectable var maxLength: Int{
        get{
            guard let l = _maxLengths[self] else{
                return 150//(global default-limit or just,Int.Max)
            }
            return l
        }
        set {
            _maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
        
    }
    
    @objc func fix(textField:UITextField){
        let t = textField.text
        let strText = t?.substring(from: 0, to: maxLength)
        textField.text = strText
    }
    func checkinput()->Bool{
        return self.text?.isEmpty ?? false || self.text?.range(of: "^[0-9a-zA-Z-]+$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    func checkInput(_allowText:String)->String{
//        if self.text?.isEmpty ?? false || self.text?.range(of: "^[0-9a-zA-Z-]+$", options: .regularExpression, range: nil, locale: nil) != nil{
//            return self.text ?? (self.text ?? "") + ""
//        }
//        return (self.text ?? "") + ""
        
        
        var str = ""
        for char in self.text!{
            let invalidCharacters = CharacterSet(charactersIn: _allowText)
            let typedCharacterSet = CharacterSet(charactersIn: String(char) )
            str+=String(char)
//            if !invalidCharacters.isSuperset(of: typedCharacterSet){
//                continue
//                //return (self.text?.substring(from: 0, to: self.text!.count-1))!
//            }
//            else{
//                str+=String(char)
//            }
        }
        str = str.substring(from: 0, to: self.maxLength) //str.substring(to: str.index(str.startIndex, offsetBy:self.maxLength))
        return str
    }
}
