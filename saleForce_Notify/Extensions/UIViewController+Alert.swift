//
//  UIViewController+Alert.swift
//  QRScanner
//
//  Created by KM, Abhilash a on 11/03/19.
//  Copyright © 2019 KM, Abhilash. All rights reserved.
//

import Foundation
import UIKit
var vSpinner:UIView?

extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.green
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    func showToastError(_message:String,_seconds: Double){
        let alert = UIAlertController(title: nil, message: _message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.orange
        alert.view.alpha = 0.3
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + _seconds) {
            alert.dismiss(animated: true)
        }
    }
    func showSpinner(onView:UIView){
        let spinnerView = UIView.init(frame:onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red:0.5,green:0.5,blue:0.5,alpha:0.5)
        let ai = UIActivityIndicatorView.init(style:.whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    func removeSpinner(){
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
