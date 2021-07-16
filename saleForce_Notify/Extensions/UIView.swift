//
//  UIView.swift
//  TasReference
//
//  Created by nextage on 2019/10/31.
//  Copyright © 2019 nextage. All rights reserved.
//

import UIKit
@IBDesignable extension UIView{
    @IBInspectable var borderColor: UIColor?{
        set{
            layer.borderColor = newValue?.cgColor
        }
        get{
            guard let color = layer.borderColor else{
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat{
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat{
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get{
            return layer.cornerRadius
        }
    }
}
