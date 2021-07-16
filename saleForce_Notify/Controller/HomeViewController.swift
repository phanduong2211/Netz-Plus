//
//  HomeViewController.swift
//  saleForce_Notify
//
//  Created by nextage on 2021/07/09.
//

import UIKit
import WebKit
class HomeViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    var  res_url=""
    var  res_token = ""
    func setValue(_url:String,_token:String)
    {
        self.res_url = _url
        self.res_token = _token
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.mainView.frame.size.width, height: self.mainView.frame.size.height))
        self.mainView.addSubview(webView)
        let url = URL(string: self.res_url)
        webView.load(URLRequest(url: url!))
        // Do any additional setup after loading the view.
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("start load")
        self.showSpinner(onView: self.view)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("loaded")
        self.removeSpinner()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("load fail")
        self.presentAlert(withTitle: "取り込みできませんでした", message: "データが取り込みできませんでした")
        self.removeSpinner()
        dismiss(animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("load fail")
        self.presentAlert(withTitle: "取り込みできませんでした", message: "データが取り込みできませんでした")
        self.removeSpinner()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnLogout_Click(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
