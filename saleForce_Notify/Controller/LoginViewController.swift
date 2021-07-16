//
//  LoginViewController.swift
//  saleForce_Notify
//
//  Created by nextage on 2021/07/09.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var textViewLogin: UITextView!
    //@IBOutlet weak var textViewPrecautions: UITextView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView();
        // Do any additional setup after loading the view.
    }
    func setView() {
        self.textViewLogin.isEditable = false
        self.textViewLogin.isUserInteractionEnabled = false
        //self.textViewPrecautions.isEditable = false
        //self.textViewPrecautions.isUserInteractionEnabled = false
    }
    
    @IBAction func enterUserName_Next(_ sender: Any) {
        self.txtPass.becomeFirstResponder()
    }
    @IBAction func login_click(_ sender: Any) {
        setbtnLoginStatus(status:true)
        var done = false
        var res_url = ""
        var res_token = ""
        var res_success = false
        var res_status = ""
        let session = URLSession.shared
        let url = "https://full-mynetz.cs112.force.com/services/apexrest/mynetzlogin"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var params :[String: Any]?
        params = ["grant_type": "password", "username": self.txtUsername.text, "password":self.txtPass.text,"device_id":self.appDelegate._device_id]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    //print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
                        res_success = (jsonResponse!["success"] as? Bool)!
                        res_status = (jsonResponse!["status"] as? String)!
                        if(res_success == true){
                            res_token = (jsonResponse!["token"] as? String)!
                            res_url = (jsonResponse!["url"] as? String)!
                        }
                        print(res_success)
                        
                    }catch _ {
                        print ("not good JSON formatted response")
                    }
                }
                done = true
            })
            task.resume()
        }catch _ {
            print ("something happened buddy")
        }
        
        repeat{ ///wait for load data complete
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        }while !done
        setbtnLoginStatus(status:false)
        if(res_success == true){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let WebResultView = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if self.checkInputText(){
                WebResultView.setValue(_url: res_url, _token: res_token)
                WebResultView.modalPresentationStyle = .fullScreen
                self.present(WebResultView, animated: true, completion: nil)
            }
        }
        else{
            print("Login fail")
            self.showToast(message: res_status)
        }
    }
    func checkInputText()->Bool{
        return true
    }
    func setbtnLoginStatus(status:Bool){
        if status{
            self.showSpinner(onView: self.view)
        }
        else{
            self.removeSpinner()
        }
    }
    /// break edit when click out textFiled
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
