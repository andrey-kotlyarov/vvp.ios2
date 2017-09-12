//
//  VIL_LoginViewController.swift
//  vvp
//
//  Created by Kotlyarov Andrey on 06.09.17.
//  Copyright © 2017 Virtual Video Pass. All rights reserved.
//

import UIKit



class VIL_LoginViewController: UIViewController
{
    @IBOutlet var imgLogo: UIImageView!
    @IBOutlet var tblLogin: UITableView!
    @IBOutlet var btnLogin: UIButton!
    
    
    fileprivate var _viuActivity: VIU_Activity?
    
    fileprivate var _txtUsername: UITextField?
    fileprivate var _txtPassword: UITextField?
    
    
    
    @IBAction func btnLogin_OnTouchUp(_ sender: Any)
    {
        self.myTask_Login()
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //CREATE gradient
        //
        //
        let gradient : CAGradientLayer = CAGradientLayer()
        
        let size: CGFloat = max(self.view.bounds.width, self.view.bounds.height)
        gradient.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: size, height: size)
        //gradient.frame = self.view.bounds
        
        let cor1: CGColor = VIM_DesignData.current.colorBG_L.cgColor
        let cor2: CGColor = VIM_DesignData.current.colorBG_D.cgColor
        let arrayColors = [cor1, cor2]
        
        gradient.colors = arrayColors
        self.view.layer.insertSublayer(gradient, at: 0)
        //
        //
        //
        
        self._viuActivity = VIU_Activity()
        
        
        //TABLE LOGIN
        self.tblLogin.layer.cornerRadius = 4.0;
        self.tblLogin.layer.masksToBounds = true;
        self.tblLogin.clipsToBounds = true;
        
        self.tblLogin.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        //self.tblLogin.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tblLogin.separatorInset = UIEdgeInsets.zero;
        
        self.tblLogin.delegate = self;
        self.tblLogin.dataSource = self;
        
        
        
        
        //BTN SIGN IN
        self.btnLogin.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        self.btnLogin.layer.cornerRadius = 4.0;
        self.btnLogin.layer.masksToBounds = true;
        self.btnLogin.clipsToBounds = true;
        
        _txtUsername = nil;
        _txtPassword = nil;
        
        
        //
        //DEBUG
        //
        if VIM_UserData.current.isDebugMode()
        {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 320, height: 120))
            //let button = UIButton(frame: imgLogo.frame)
            button.backgroundColor = UIColor.white.withAlphaComponent(0.25)
            button.setTitle("", for: UIControlState.normal)
            button.addTarget(self, action: #selector(btnFillUsernamePassword_OnTouchUp), for: UIControlEvents.touchUpInside)
            
            self.view.addSubview(button)
        }
    }
    
    
    var fillIndex = -1
    func btnFillUsernamePassword_OnTouchUp(_ sender: Any)
    {
        
        let usernames = ["admin@westeros.com", "eddard_stark@westeros.com", "jon_snow@westeros.com", "cersei_lannister@westeros.com", "tyrion_lannister@westeros.com", "daenerys_targaryen@westeros.com", "theon_greyjoy@westeros.com", "yara_greyjoy@westeros.com", "brienne_of_tarth@westeros.com", ""]
        let passwords = ["a12345678", "eS12345678", "jS12345678", "cL12345678", "tL12345678", "dT12345678", "tG12345678", "yG12345678", "bT12345678", ""]
        
        
        fillIndex = (fillIndex + 1) % usernames.count
        
        
        _txtUsername?.text = usernames[fillIndex]
        _txtPassword?.text = passwords[fillIndex]
        
    }
    
    
    override func viewDidLayoutSubviews()
    {
        self.tblLogin.layoutMargins = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    //
    // My Private Methods
    //
    
    private func myHideKeyboard()
    {
        self._txtUsername?.resignFirstResponder()
        self._txtPassword?.resignFirstResponder()
    }
    
    
    
    private func myDidError(_ title: String, errorMessage: String) -> Void
    {
        self.myHideKeyboard()
        
        
        let alertController = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alertController.view.tintColor = VIM_DesignData.current.colorTint
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)
        
        return
    }
    
    private func myDidError(_ title: String, error: Error?) -> Void
    {
        self.myDidError(title, errorMessage: error?.localizedDescription ?? "")
    }
    
    
    
    private func myTask_Login() -> Void
    {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self._viuActivity?.show()
        self.myHideKeyboard()
        
        
        
        let viuRequest: VIU_Request = VIU_Request(cmd: "login")
        
        viuRequest.addPostValue(self._txtUsername!.text!, forKey: "username")
        viuRequest.addPostValue(self._txtPassword!.text!, forKey: "password")
        viuRequest.addPostValue(String(VIM_DesignData.current.sizeType), forKey: "sizetype")
        
        //DEBUG
        //viuRequest.addPostValue("2500", forKey: "_delay_")
        
        //DEBUG
        //print(viuRequest)
        
        let task = URLSession.shared.dataTask(
            with: viuRequest.urlRequest(),
            completionHandler:
            {
                (data: Data?, response: URLResponse?, error: Error?) in
                
                //
                // completionHandler START
                //
                //
                
                //DEBUG
                //print("data: \(data)")
                //print("response: \(response)")
                //print("error: \(error)")
                
                DispatchQueue.main.async()
                {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self._viuActivity?.hide()
                    
                    if error != nil || response == nil || data == nil
                    {
                        self.myDidError("URL Error", error:error)
                        return
                    }
                    
                    if (response as? HTTPURLResponse)!.statusCode / 100 != 2 || response!.mimeType != "application/json"
                    {
                        self.myDidError("HTTP Error", errorMessage: "HTTP error details:\nmime-type: \(response!.mimeType ?? "-")\nstatus-code: \((response as? HTTPURLResponse)!.statusCode)")
                        return
                    }
                    
                    do
                    {
                        let allJsonData: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
                        
                        let json_code = allJsonData["code"] as! Int
                        let json_mess = allJsonData["mess"] as! String
                        
                        //DEBUG
                        //print("JSON: \(allJsonData)")
                        //print("JSON_code: \(json_code); JSON_mess: \(json_mess)")
                        
                        if json_code != 0
                        {
                            if json_code == 2
                            {
                                self._txtPassword?.text = ""
                            }
                            
                            
                            self.myDidError("API Error", errorMessage: json_mess + "\n(code = \(json_code))")
                            return
                        }
                        
                        
                        
                        let json_data = allJsonData["data"] as! NSDictionary
                        VIM_AuthData.current.updateBy(json_data)
                        
                        VIM_UserData.current.token = VIM_AuthData.current.token
                        VIM_UserData.current.orgId = VIM_AuthData.current.org?.orgId
                        VIM_UserData.current.saveUserData()
                        
                        
                        let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilNavMenu") as! VIL_MenuNavController
                        self.present(vcMenu, animated: false, completion: nil)
                        
                        /*
                        if VIM_AuthData.current.org != nil
                        {
                            //GOTO Menu ControllView
                            
                         
                            
                            //let vcMenu = self.storyboard?.instantiateViewController(withIdentifier: "vilMenu") as! VIL_MenuViewController
                            //self.present(vcMenu, animated: false, completion: nil)
                        }
                        else
                        {
                            //GOTO Select Orgs ControllView
                            //TODO
                        }
                        */
                    }
                    catch let jsonError as NSError
                    {
                        self.myDidError("JSON Error", error:(jsonError as Error))
                        return
                    }
                    
                    
                    return
                }
                
                //
                // completionHandler END
                //
                //
            }
        )
        task.resume()
        
    }
    
}



extension VIL_LoginViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == self.tblLogin)
        {
            return 2
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: VIL_LoginTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LoginCell", for: indexPath) as! VIL_LoginTableViewCell
         
        if (indexPath.row == 0)
        {
            cell.txtField.placeholder = "Username";
            
            cell.txtField.delegate = self
            cell.txtField.keyboardAppearance = UIKeyboardAppearance.dark
            cell.txtField.keyboardType = UIKeyboardType.default
            cell.txtField.isSecureTextEntry = false
            
            self._txtUsername = cell.txtField
            self._txtUsername?.becomeFirstResponder()
        }
        
        if (indexPath.row == 1)
        {
            cell.txtField.placeholder = "Password";
            
            cell.txtField.delegate = self
            cell.txtField.keyboardAppearance = UIKeyboardAppearance.dark
            cell.txtField.keyboardType = UIKeyboardType.default
            cell.txtField.isSecureTextEntry = true
            
            self._txtPassword = cell.txtField
        }
 
        return cell
    }
}

extension VIL_LoginViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44.0
    }
}

extension VIL_LoginViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == self._txtUsername
        {
            self._txtPassword?.becomeFirstResponder()
        }
        /*
        else if textField == self._txtPassword
        {
            self._txtEmail?.becomeFirstResponder()
        }
        */
        else
        {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
